//
//  AppDelegate.swift
//  Badapin
//
//  Created by Leonardo Olivares on 19-04-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit
import CoreData
import AWSCore


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize the Amazon Cognito credentials provider
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.USEast1, identityPoolId: "us-east-1:57689403-c2c5-4927-a4cf-f34d4b07d4e6")
        let defaultServiceConfiguration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = defaultServiceConfiguration
        
        ////////////////
        
        
        let color = UIColor(red: 153.0/255.0, green: 0.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        UITabBar.appearance().barTintColor = color
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var initialViewController : UIViewController
        
        if (User.is_token) {
            User.fetch(){}
            initialViewController = storyboard.instantiateViewControllerWithIdentifier("mainTabController") 
        } else {
            initialViewController = storyboard.instantiateViewControllerWithIdentifier("loginController") 
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

}

