//
//  UserListCell.swift
//  Badapin
//
//  Created by Leonardo Olivares on 18-08-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nick: UILabel!
    
    var user_id = "no-id"
    
    @IBAction func addUser(sender: AnyObject) {
        print("add user id: \(self.user_id)")
        
        User.addUser(self.user_id) {
            (flag, msg) in
            if (flag) {
                let errorMsg = UIAlertView(title: "Add User", message: "Usuario Seguido!", delegate: self, cancelButtonTitle: "OK")
                errorMsg.show()
            } else {
                let errorMsg = UIAlertView(title: "ERROR", message: msg!, delegate: self, cancelButtonTitle: "OK")
                errorMsg.show()
            }
        }
    }
}
