//
//  AppDelegate.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-25.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func appBadge() {
        Kinvey.sharedClient.push.badgeNumber = 100 //sets to 100
        
        Kinvey.sharedClient.push.resetBadgeNumber() //sets badgeNumber to 0
    }
    
    func encrypted() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            encrypted: true
        )
    }
    
    func micApiVersion() {
        Client.sharedClient.micApiVersion = "v2" //v1 is the default value
    }
    
#if swift(>=3.0)
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
//        Kinvey.sharedClient.initialize(
//            appKey: "kid_WyWKm0pPM-",
//            appSecret: "1f94baeb156b4acf9674f979df680ca2"
//        )
//        
//        Kinvey.sharedClient.initialize(
//            appKey: "kid_WyWKm0pPM-",
//            appSecret: "1f94baeb156b4acf9674f979df680ca2",
//            apiHostName: URL(string: "https://baas.kinvey.com/")!
//        )
//    
//        Kinvey.sharedClient.userType = CustomUser.self
//        
//        return true
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        //Your App Setup...
        
        Kinvey.sharedClient.initialize(appKey: "<#Your app key#>", appSecret: "<#Your app secret#>")
        
        Kinvey.sharedClient.push.registerForPush()
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Push Notification handling code should be performed here
    }
    
    func encryption() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            encryptionKey: "<#Your encryption key#>".data(using: .utf8)
        )
    }
    
    func mic1() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            authHostName: URL(string: "<#https://my-subdomain.kinvey.com#>")!
        )
    }
    
    func presentMICViewController() {
        let redirect = URL(string: "<#myRedirectUri://#>")! //this uri must match one of the uris configured in your app's "Auth Source"
        User.presentMICViewController(redirectURI: redirect) { user, error in
            if (user != nil) {
                //logged in successfully
            } else if (error != nil) {
                //something went wrong if the error object is not nil
            } else {
                //should never happen!
            }
        }
    }
    
    func loginAuthorization() {
        User.loginWithAuthorization(
            redirectURI: URL(string: "<#myRedirectURI://#>")!,
            username: "<#myUsername#>",
            password: "<#myPassword#>"
        ) { user, error in
            if let user = user {
                //logged in successfully
                print("User: \(user)")
            } else if let error = error {
                //something went wrong if the error object is not nil
                print("Error: \(error)")
            } else {
                //should never happen!
            }
        }
    }
    
#else
    
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
//        Kinvey.sharedClient.initialize(
//            appKey: "<#Your app key#>",
//            appSecret: "<#Your app key#>"
//        )
//    
//        Kinvey.sharedClient.initialize(
//            appKey: "<#Your app key#>",
//            appSecret: "<#Your app key#>",
//            apiHostName: NSURL(string: "<#https://my-subdomain.kinvey.com/#>")!
//        )
//        
//        Kinvey.sharedClient.userType = CustomUser.self
//    
//        return true
//    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        //Your App Setup...
        
        Kinvey.sharedClient.initialize(appKey: "<#Your app key#>", appSecret: "<#Your app key#>")
        
        Kinvey.sharedClient.push.registerForPush()
        
        return true
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        // Push Notification handling code should be performed here
    }
    
    func encryption() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            encryptionKey: "<#Your encryption key#>".dataUsingEncoding(NSUTF8StringEncoding)
        )
    }
    
    func mic1() {
        Kinvey.sharedClient.initialize(
            appKey: "<#Your app key#>",
            appSecret: "<#Your app secret#>",
            authHostName: NSURL(string: "<#https://my-subdomain.kinvey.com#>")!
        )
    }
    
    func presentMICViewController() {
        let redirect = NSURL(string: "<#myRedirectUri://#>")! //this uri must match one of the uris configured in your app's "Auth Source"
        User.presentMICViewController(redirectURI: redirect) { user, error in
            if (user != nil) {
                //logged in successfully
            } else if (error != nil) {
                //something went wrong if the error object is not nil
            } else {
                //should never happen!
            }
        }
    }
    
    func loginAuthorization() {
        User.loginWithAuthorization(
            redirectURI: NSURL(string: "<#myRedirectURI://#>")!,
            username: "<#myUsername#>",
            password: "<#myPassword#>"
        ) { user, error in
            if let user = user {
                //logged in successfully
                print("User: \(user)")
            } else if let error = error {
                //something went wrong if the error object is not nil
                print("Error: \(error)")
            } else {
                //should never happen!
            }
        }
    }
    
#endif
    
}
