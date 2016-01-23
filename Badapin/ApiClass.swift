//
//  ApiClass.swift
//  Badapin
//
//  Created by Leonardo Olivares on 26-07-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import Foundation

class ApiClass {
    var url : String = ""
    let api_base_url : String
    let request : NSMutableURLRequest = NSMutableURLRequest()
    let session: NSURLSession = NSURLSession.sharedSession()
    
    init() {
        self.api_base_url = (NSBundle.mainBundle().objectForInfoDictionaryKey("api_base_url") as? String ?? nil)!
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    init(_ token : String) {
        self.api_base_url = (NSBundle.mainBundle().objectForInfoDictionaryKey("api_base_url") as? String ?? nil)!
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.addValue("application/json", forHTTPHeaderField: "Accept")
        self.request.addValue(token, forHTTPHeaderField: "Api-Token")
    }
    
    func URL(path: String) -> ApiClass {
        self.url = self.api_base_url + path
        
        return self
    }
    
    func GET(callback: (Bool, JSON) -> Void) -> Void {
        self.request.HTTPMethod = "GET"
        self.request.HTTPBody = nil
        
        self.call(callback)
    }
    
    func POST(params : Dictionary<String, String>, callback: (Bool, JSON) -> Void) -> Void {
        request.HTTPMethod = "POST"
        
        do {
            self.request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            self.call(callback)
        } catch {
            print(error)
        }
    }
    
    func UPLOAD(data: NSData, callback: (Bool, JSON) -> Void) -> Void {
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        
        body.appendData(NSString(format: "--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format: "Content-Disposition: form-data; name=\"image\"; filename=\"image.png\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format: "Content-Type: image/png\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(data)
        body.appendData(NSString(format: "\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        
        body.appendData(NSString(format: "--\(boundary)--\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        request.setValue("\(body.length)", forHTTPHeaderField:"Content-Length")
        request.HTTPBody = body
        
        self.call() {
            (flag, resp) in
            self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            callback(flag, resp)
        }
    }
    
    func percentEscapeString(string: String) -> String {
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
            string,
            nil,
            ":/?@!$&'()*+,;=",
            CFStringBuiltInEncodings.UTF8.rawValue) as String;
    }
    
    
    func PUT(params : Dictionary<String, String>, callback: (Bool, JSON) -> Void) -> Void {
        request.HTTPMethod = "PUT"
        
        do {
            self.request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            self.call(callback)
        } catch {
            print(error)
        }
    }
    
    func call(callback: (Bool, JSON) ->Void) -> Void {
        self.request.URL = NSURL(string: self.url)
        
        let task = self.session.dataTaskWithRequest(self.request, completionHandler: {data, response, error -> Void in
            if (error == nil) {
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    callback(true, JSON(data: data!))
                })
            } else {
                print("error: \(error)\n")
                print("response: \(response)\n")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    callback(false, nil)
                })
            }
        })
        
        task.resume()
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }

}

let ApiCall = ApiClass()