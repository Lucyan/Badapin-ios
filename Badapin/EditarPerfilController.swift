//
//  EditarPerfilController.swift
//  Badapin
//
//  Created by Leonardo Olivares on 26-07-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit

class EditarPerfilController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nickText: UITextField!
    @IBOutlet weak var generoText: UITextField!
    @IBOutlet weak var fechaText: UITextField!
    
    @IBOutlet var view_main: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Editar Perfil"
        
        if let email = User.data["email"].string {
            self.emailText.text = email
        }
        
        if let nick = User.data["nick"].string {
            self.nickText.text = nick
        }
        
        if let genero = User.data["genre"].string {
            self.generoText.text = genero
        }
        
        if let fecha = User.data["birthday"].string {
            self.fechaText.text = fecha
        }
        
        emailText.delegate = self
        nickText.delegate = self
        generoText.delegate = self
        fechaText.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterFromKeyboardNotifications()
    }
    
    func textFieldShouldReturn(txt : UITextField) -> Bool {
        switch (txt.tag) {
        case 1 :
            nickText.becomeFirstResponder()
        case 2 :
            generoText.becomeFirstResponder()
        case 3 :
            fechaText.becomeFirstResponder()
        case 4 :
            self.guardarDatos()
        default:
            return false
        }
        
        return true
    }
    
    func registerForKeyboardNotifications ()-> Void   {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications () -> Void {
        let center:  NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
        center.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            //self.view_main.frame.origin.y = keyboardFrame.size.height * -1
            self.view_main.frame.size.height = self.view_main.frame.size.height - keyboardFrame.size.height
        })
    }
    
    func keyboardWillBeHidden(notification : NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view_main.frame.origin.y = 0
        })
    }
    
    @IBAction func guardarDatos() {
        User.update([
            "email": emailText.text!,
            "nick": nickText.text!,
            "genre": generoText.text!,
            "birthday": fechaText.text!
        ]) {
            (flag, msg) -> Void in
            if (flag) {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                let errorMsg = UIAlertView(title: "Error", message: msg, delegate: self, cancelButtonTitle: "OK")
                errorMsg.show()
            }
        }
    }
}
