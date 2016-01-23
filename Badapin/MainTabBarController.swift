//
//  MainTabBarController.swift
//  Badapin
//
//  Created by Leonardo Olivares on 22-04-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit
import imglyKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    let cameraViewController = IMGLYCameraViewController(recordingModes: [.Photo])
    let editorViewController = IMGLYMainEditorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self;
        
        cameraViewController.squareMode = true
        cameraViewController.completionBlock = completitionCamara
        
        editorViewController.initialFilterType = .None
        editorViewController.initialFilterIntensity = 0.5
        editorViewController.completionBlock = editorCompletionBlock
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController.title == "foto") {
            callCamaraViewController()
            return false
        }
        
        return true;
    }
    
    func callCamaraViewController() {
        self.presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    func completitionCamara(imagen: UIImage?, url: NSURL?) {
        editorViewController.highResolutionImage = imagen
        
        let navigationController = IMGLYNavigationController(rootViewController: self.editorViewController)
        navigationController.navigationBar.barStyle = .Black
        navigationController.navigationBar.translucent = false
        navigationController.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.whiteColor() ]
        
        cameraViewController.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func editorCompletionBlock(result: IMGLYEditorResult, image: UIImage?) {
        if let image = image where result == .Done {
            User.uploadImage(image) {
                (flag, error) -> Void in
                print("fin upload")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}