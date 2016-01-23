//
//  UserList.swift
//  Badapin
//
//  Created by Leonardo Olivares on 18-08-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import Foundation
import UIKit

var userListMng = UserList()

struct UserData {
    var nick = "no-nick"
    var avatar_url = "no-url"
    var avatar : UIImage?
    var user_id = "no-id"
}

class UserList {
    var ApiCall : ApiClass
    
    var list = [UserData]()
    
    init() {
        self.ApiCall = ApiClass()
    }
    
    func addUser(data: JSON) {
        var newUser = UserData()
        
        if let nick = data["nick"].string {
            newUser.nick = nick
        }
        
        if let avatar = data["avatar"].string {
            newUser.avatar_url = avatar
        }
        
        if let user_id = data["_id"].string {
            newUser.user_id = user_id
        }
        
        self.list.append(newUser)
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
    
    func search(nick: String, callback: () -> Void) {
        list = [UserData]()
        self.ApiCall.URL("users/search?nick=\(nick)").GET() {
            (flag, resp) -> Void in
            if (flag) {
                if let code = resp["code"].number {
                    if (code == 0) {
                        for (_, element) in resp["users"] {
                            self.addUser(element)
                        }
                    }
                }
                
                callback()
            }
        }
    }
}