//
//  FotoController.swift
//  Badapin
//
//  Created by Leonardo Olivares on 04-08-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit

class FotoController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var fotoView: UIImageView!
    @IBOutlet weak var descripcionText: UITextField!
    
    @IBOutlet var view_main: UIView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descripcionText.delegate = self
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
        self.descripcionText.endEditing(true)
        
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
            self.view_main.frame.origin.y = keyboardFrame.size.height * -1
        })
    }
    
    func keyboardWillBeHidden(notification : NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view_main.frame.origin.y = 0
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (fotoView.image == nil) {
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            
            imagePicker.allowsEditing = true
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        fotoView.image = info[UIImagePickerControllerEditedImage] as? UIImage
    }
    
    @IBAction func guardarImagen(sender: UIBarButtonItem) {
        self.descripcionText.endEditing(true);
        
        User.uploadImage(fotoView.image!) {
            (flag, error) -> Void in
            self.tabBarController?.selectedIndex = 0
            print("fin upload")
        }
    }
    
}
