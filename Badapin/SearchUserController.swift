//
//  SearchUserController.swift
//  Badapin
//
//  Created by Leonardo Olivares on 18-08-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit

class SearchUserController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableViewList: UITableView!
    @IBOutlet weak var txt_nick: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Buscar"
    }

    @IBAction func searchUser(sender: UIButton) {
        self.view.endEditing(true)
        userListMng.search(txt_nick.text!) {
            () in
            self.tableViewList.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListMng.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UserListCell = tableViewList.dequeueReusableCellWithIdentifier("userlistcell") as! UserListCell
        
        cell.nick.text = userListMng.list[indexPath.row].nick
        cell.user_id = userListMng.list[indexPath.row].user_id
        
        userListMng.getAvatar(indexPath.row) {
            (imagen) in
            cell.avatar.image = imagen
        }
        
        return cell
    }
}
