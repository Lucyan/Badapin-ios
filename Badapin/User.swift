//
//  User.swift
//  Badapin
//
//  Created by Leonardo Olivares on 21-04-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import Foundation
import AWSS3


class UserClass {
    var token : String?
    var ApiCall : ApiClass
    
    var data : JSON = []
    var is_token : Bool
    
    init() {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let token = defaults.objectForKey("user_token") as? String {
            self.token = token
            self.ApiCall = ApiClass(token)
            self.is_token = true
        } else {
            self.token = nil
            self.ApiCall = ApiClass()
            self.is_token = false
        }
    }
    
    func update(params: Dictionary<String, String>, callback: (Bool, String?) -> Void) -> Void {
        self.ApiCall.URL("users/me").PUT(params) {
            (flag, resp) -> Void in
            if (flag) {
                if let message = resp["err", "message"].string {
                    callback(false, message)
                } else {
                    callback(true, nil)
                }
            }
        }
    }
    
    func fetch(callback : () -> Void) -> Void {
        self.ApiCall.URL("users/me").GET() {
            (flag, resp) -> Void in
            if (flag) {
                self.data = resp
                callback()
            }
        }
    }
    
    func login(params: Dictionary<String, String>, callback: (login: Bool) -> Void) -> Void {
        self.ApiCall.URL("users/login").POST(params) {
                (flag: Bool, resp: JSON) -> Void in
                if (flag) {
                    if let token = resp["token"].string {
                        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        
                        defaults.setObject(token, forKey: "user_token");
                        
                        defaults.synchronize()
                        
                        self.token = token
                        self.ApiCall = ApiClass(token)
                        self.is_token = true
                        
                        streamMng.changeToken(token)
                        
                        callback(login: true)
                    } else {
                        callback(login: false)
                    }
                }
        }
    }
    
    func logout() {
        self.data = []
        self.token = nil
        self.ApiCall = ApiClass()
        self.is_token = false
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        defaults.removeObjectForKey("user_token")
        
        defaults.synchronize()
    }
    
    func register(params: Dictionary<String, String>, callback: (login : Bool, msg_error : String?) -> Void) -> Void {
        self.ApiCall.URL("users").POST(params) {
                (flag: Bool, resp: JSON) -> Void in
                if (flag) {
                    if let message = resp["err", "message"].string {
                        callback(login: false, msg_error: message)
                    } else {
                        if let token = resp["token"].string {
                            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            
                            defaults.setObject(token, forKey: "user_token");
                            
                            defaults.synchronize()
                            
                            self.token = token
                            self.ApiCall = ApiClass(token)
                            self.is_token = true
                            
                            streamMng.changeToken(token)
                            
                            callback(login: true, msg_error: nil)
                        }
                    }
                }
        }
    }
    
    func uploadImage(imagen: UIImage, callback: (Bool, String?) -> Void) {
        
        var fileName = "test/imagen.jpg"
        
        if let user_id = self.data["_id"].string {
            fileName = "\(user_id)/\(NSDate().timeIntervalSince1970 * 1000).jpg"
            
        }
        
        let path = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("imagen.jpg")
        let imageData = UIImageJPEGRepresentation(imagen, 0.7)
        imageData?.writeToFile(path, atomically: true)
        
        let url = NSURL.init(fileURLWithPath: path)
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        
        uploadRequest.bucket = "s3-badapin-fileserver"
        uploadRequest.ACL = AWSS3ObjectCannedACL.PublicRead
        uploadRequest.key = "images/\(fileName)"
        uploadRequest.contentType = "image/jpeg"
        uploadRequest.body = url
        
        // we will track progress through an AWSNetworkingUploadProgressBlock
        uploadRequest?.uploadProgress = {[unowned self](bytesSent:Int64, totalBytesSent:Int64, totalBytesExpectedToSend:Int64) in
            
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                print("progress: \((totalBytesSent * 100) / totalBytesExpectedToSend)%")
            })
        }
        
        // now the upload request is set up we can creat the transfermanger, the credentials are already set up in the app delegate
        let transferManager:AWSS3TransferManager = AWSS3TransferManager.defaultS3TransferManager()
        // start the upload
        transferManager.upload(uploadRequest).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock:{ [unowned self]
            task -> AnyObject in
            
            // once the uploadmanager finishes check if there were any errors
            if(task.error != nil){
                print("Error: %@", task.error);
            }else{ // if there aren't any then the image is uploaded!
                // this is the url of the image we just uploaded
                
                let images_url = (NSBundle.mainBundle().objectForInfoDictionaryKey("images_url") as? String ?? nil)!
                let url: String = "\(images_url)\(fileName)"
                
                self.ApiCall.URL("stream/public").POST([
                    "url": url
                ]) {
                    (flag, data) in
                    callback(true, nil)
                }
            }
            
            return true;
        })
    }
    
    func addUser(user_id: String, callback: (Bool, String?) -> Void) {
        self.ApiCall.URL("users/seguidos").POST([
            "seguir_id" : user_id
            ]) {
            (flag, resp) in
            if (flag) {
                if let code = resp["code"].number {
                    if code == 0 {
                        callback(true, nil)
                    } else {
                        if let msg = resp["msg"].string {
                            callback(false, msg)
                        }
                    }
                }
            }
        }
    }
}

let User = UserClass()