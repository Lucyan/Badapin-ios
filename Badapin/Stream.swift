//
//  Stream.swift
//  Badapin
//
//  Created by Leonardo Olivares on 16-08-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import Foundation
import UIKit

var streamMng : StreamManager = StreamManager()

struct StreamData {
    var nick = "no-nick"
    var avatar_url = "no-url"
    var avatar : UIImage?
    var imagen_url = "no-url"
    var imagen : UIImage?
    var descripcion = ""
    var stream_id = "no-id"
    var created: String?
}

class StreamManager {
    var ApiCall : ApiClass
    
    var list = [StreamData]()
    var last:String? = nil
    var getMore = true
    var getNews = false
    
    init() {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let token = defaults.objectForKey("user_token") as? String {
            self.ApiCall = ApiClass(token)
        } else {
            self.ApiCall = ApiClass()
        }
        
        list = [StreamData]()
    }
    
    func addData(data: JSON) {
        var newData = StreamData()
        
        if let nick = data["user", "nick"].string {
            newData.nick = nick
        }
        
        if let avatar = data["user", "avatar"].string {
            newData.avatar_url = avatar
        }
        
        if let descripcion = data["descripcion"].string {
            newData.descripcion = descripcion
        }
        
        if let url = data["url"].string {
            newData.imagen_url = url
        }
        
        if let descripcion = data["descripcion"].string {
            newData.descripcion = descripcion
        }
        
        if let stream_id = data["_id"].string {
            newData.stream_id = stream_id
        }
        
        if let created = data["created"].string {
            newData.created = created
            if self.getNews == false {
                self.last = created
            }
        }
        
        if self.getNews {
            self.list.insert(newData, atIndex: 0);
        } else {
            self.list.append(newData);
        }
    }
    
    func getAvatar(index: Int, callback: (UIImage) -> Void) {
        if (self.list[index].avatar != nil) {
            callback(self.list[index].avatar!)
        } else {
            if let avatarUrl = NSURL(string: self.list[index].avatar_url) {
                downloadImage(avatarUrl) {
                    (flag, data) -> Void in
                    if (flag) {
                        self.list[index].avatar = UIImage(data: data!)!
                        callback(self.list[index].avatar!)
                    }
                }
            }
        }
    }
    
    func getImagen(index: Int, callback: (UIImage) -> Void) {
        if (self.list[index].imagen != nil) {
            callback(self.list[index].imagen!)
        } else {
            //print(self.list[index].imagen_url)
            if let imagenUrl = NSURL(string: self.list[index].imagen_url) {
                downloadImage(imagenUrl) {
                    (flag, data) -> Void in
                    if (flag) {
                        self.list[index].imagen = UIImage(data: data!)!
                        callback(self.list[index].imagen!)
                    }
                }
            }
        }
    }
    
    func changeToken(token: String) {
        self.ApiCall = ApiClass(token)
    }
    
    func fetch(news: Bool, callback: () -> Void) {
        if (self.getMore == true || news == true) {
            var url = "stream/"
            if (self.last != nil && news == false) {
                url = "stream/?last=\(self.last!)"
            } else if (news == true && self.list.count > 0) {
                self.getNews = true;
                url = "stream/?first=\(self.list[0].created!)"
            }
            //print(url)
            self.ApiCall.URL(url).GET() {
                (flag, resp) -> Void in
                if (flag) {
                    if let code = resp["code"].number {
                        if (code == 0) {
                            for (_, element) in resp["streams"] {
                                self.addData(element)
                            }
                        } else if (code == 1) {
                            self.getMore = false;
                        }
                        
                        self.getNews = false;
                    }
                    
                    callback()
                }
            }
        } else {
            callback()
        }
    }
    
    func votar(palabra_id: Int, stream_id: String, callback: (JSON) -> Void) -> Void {
        var palabra : String
        
        switch (palabra_id) {
        case 0:
            palabra = "Aburrido"
        case 1:
            palabra = "Ego"
        case 2:
            palabra = "Estilo"
        case 3:
            palabra = "Sexo"
        case 4:
            palabra = "Amor"
        case 5:
            palabra = "Belleza"
        case 6:
            palabra = "Freak"
        case 7:
            palabra = "Fuerza"
        case 8:
            palabra = "Salvaje"
        case 9:
            palabra = "Gracioso"
        default:
            return
        }
        
        self.ApiCall.URL("stream/votar").POST([
            "stream_id" : stream_id,
            "palabra" : palabra
            ]) {
            (flag, resp) -> Void in
            if (flag) {
                callback(resp)
            }
        }
    }
    
    func checkVotacion(stream_id: String, callback: (Bool) -> Void) -> Void {
        self.ApiCall.URL("stream/votar/check?stream_id=\(stream_id)").GET() {
            (flag, resp) in
            if (flag) {
                if let code = resp["code"].int {
                    if (code == 1) {
                        callback(true)
                    } else {
                        callback(false)
                    }
                }
            }
        }
    }
    
    func getVotacion(stream_id: String, callback: (Bool, JSON) -> Void) -> Void {
        self.ApiCall.URL("stream/votar?stream_id=\(stream_id)").GET() {
            (flag, data) in
            callback(flag, data);
        }
    }
}