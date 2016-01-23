//
//  PerfilController.swift
//  Badapin
//
//  Created by Leonardo Olivares on 25-07-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit

class PerfilController: UIViewController {

    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        User.fetch()
            {   
                if let nick = User.data["nick"].string {
                    self.nickLabel.text = "@" + nick
                }
                
                if let avatarUrl = User.data["avatar"].string {
                    if let checkUrl = NSURL(string: avatarUrl) {
                        downloadImage(checkUrl) {
                            (flag, data) -> Void in
                            if (flag) {
                                self.avatar.image = UIImage(data: data!)
                            }
                        }
                    }
                }
                
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        User.logout()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainTabController = storyboard.instantiateViewControllerWithIdentifier("loginController") 
        
        self.presentViewController(mainTabController, animated: true, completion: nil)
    }
    
}
