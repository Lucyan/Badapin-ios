//
//  LoginController.swift
//  Badapin
//
//  Created by Leonardo Olivares on 21-04-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tab_arrow: UIImageView!
    @IBOutlet weak var tabOptionsView: UIView!
    
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_registro: UIButton!
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_email_registro: UITextField!
    @IBOutlet weak var txt_nick_registro: UITextField!
    @IBOutlet weak var genre_registro: UISegmentedControl!
    @IBOutlet weak var txt_password_registro: UITextField!
    @IBOutlet weak var txt_repeat_password_registro: UITextField!
    @IBOutlet weak var txt_fecha_nac: UITextField!
    
    @IBOutlet weak var lbl_mensaje: UILabel!
    
    @IBOutlet weak var view_registro: UIView!
    @IBOutlet weak var view_login: UIView!
    @IBOutlet var view_main: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txt_email.delegate = self
        txt_password.delegate = self
        txt_email_registro.delegate = self
        txt_nick_registro.delegate = self
        txt_password_registro.delegate = self
        txt_repeat_password_registro.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        posArrow(btn_login)
        lbl_mensaje.text = "Inicia sesión para ver y votar en secreto las fotos de tus amigos"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterFromKeyboardNotifications()
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        if (sender.text != "") {
            let dateFormatter = NSDateFormatter()
            
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            datePickerView.date = dateFormatter.dateFromString(sender.text!)!
        }
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        txt_fecha_nac.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(txt : UITextField) -> Bool {
        switch (txt.tag) {
        case 1 :
            txt_password.becomeFirstResponder()
        case 2 :
            self.goToLogin()
        case 3 :
            txt_nick_registro.becomeFirstResponder()
        case 4 :
            txt_fecha_nac.becomeFirstResponder()
        case 5 :
            txt_password_registro.becomeFirstResponder()
        case 6 :
            txt_repeat_password_registro.becomeFirstResponder()
        case 7 :
            self.goToRegistro()
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
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view_main.frame.origin.y = (self.tabOptionsView.frame.origin.y * -1) + 20
        })
        
        lbl_mensaje.hidden = true;
    }
    
    func keyboardWillBeHidden(notification : NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view_main.frame.origin.y = 0
        })
        
        lbl_mensaje.hidden = false
    }
    
    @IBAction func clickRegistro(sender: UIButton) {
        posArrow(btn_registro)
        view_login.hidden = true
        view_registro.hidden = false
        lbl_mensaje.text = "Registrate para ver y votar en secreto las fotos de tus amigos"
        self.view.endEditing(true)
    }
    
    @IBAction func clickLogin(sender: UIButton) {
        posArrow(btn_login)
        view_registro.hidden = true
        view_login.hidden = false
        lbl_mensaje.text = "Inicia sesión para ver y votar en secreto las fotos de tus amigos"
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnLogin(sender: UIButton) {
        self.goToLogin()
    }
    
    @IBAction func clickBtnRegistro(sender: AnyObject) {
        self.goToRegistro()
    }
    
    func posArrow(btn : UIButton) {
        tab_arrow.frame.origin.x = (btn.frame.origin.x + (btn.frame.size.width / 2)) - (tab_arrow.frame.size.width / 2 )
        
        tab_arrow.hidden = false;
    }
    
    func goToLogin() -> Bool {
        let email = txt_email.text
        let password = txt_password.text
        
        if (!Regex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email!)) {
            let errorMsg = UIAlertView(title: "Error", message: "E-Mail Inválido", delegate: self, cancelButtonTitle: "OK")
            errorMsg.show()
            return false
        }
        
        if (password?.characters.count < 6) {
            let errorMsg = UIAlertView(title: "Error", message: "Password Inválida (menor a 6 caractéres)", delegate: self, cancelButtonTitle: "OK")
            errorMsg.show()
            return false
        }
        
        self.view.endEditing(true)
        
        User.login([
            "email": email!,
            "password": password!]) {
            (login) -> Void in
                if (login) {
                    self.nextView();
                } else {
                    let errorMsg = UIAlertView(title: "Error", message: "E-Mail o Password no coinciden", delegate: self, cancelButtonTitle: "OK")
                    errorMsg.show()
                }
        }
        
        return true
    }
    
    func goToRegistro() -> Bool {
        let email = txt_email_registro.text
        let nick = txt_nick_registro.text
        var genre = "M"
        switch genre_registro.selectedSegmentIndex {
        case 1:
            genre = "F"
        default:
            genre = "M"
        }
        
        let birthday = txt_fecha_nac.text
        let password = txt_password_registro.text
        let repeat_password = txt_repeat_password_registro.text
        
        if (!Regex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}").test(email!)) {
            let errorMsg = UIAlertView(title: "Error", message: "E-Mail Inválido", delegate: self, cancelButtonTitle: "OK")
            errorMsg.show()
            txt_email_registro.becomeFirstResponder()
            return false
        }
        
        if (nick?.characters.count < 3) {
            let errorMsg = UIAlertView(title: "Error", message: "Nick menor a 3 caractéres", delegate: self, cancelButtonTitle: "OK")
            errorMsg.show()
            txt_nick_registro.becomeFirstResponder()
            return false
        }
        
        if (password?.characters.count < 6) {
            let errorMsg = UIAlertView(title: "Error", message: "Password menor a 6 caracteres", delegate: self, cancelButtonTitle: "OK")
            errorMsg.show()
            txt_password_registro.becomeFirstResponder()
            return false
        }
        
        if (password != repeat_password) {
            let errorMsg = UIAlertView(title: "Error", message: "Password no coinciden", delegate: self, cancelButtonTitle: "OK")
            errorMsg.show()
            txt_repeat_password_registro.becomeFirstResponder()
            return false
        }
        
        self.view.endEditing(true)
        
        User.register([
            "email": email!,
            "nick": nick!,
            "password": password!,
            "genre": genre,
            "birthday": birthday!]) {
            (login, message) -> Void in
            if (login) {
                self.nextView();
            } else {
                let errorMsg = UIAlertView(title: "Error", message: message, delegate: self, cancelButtonTitle: "OK")
                errorMsg.show()
            }
        }
        
        return true
    }
    
    func nextView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainTabController = storyboard.instantiateViewControllerWithIdentifier("mainTabController")
        
        self.presentViewController(mainTabController, animated: true, completion: nil)
    }
}


