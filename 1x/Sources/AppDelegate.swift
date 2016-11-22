//
//  AppDelegate.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-25.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

#if swift(>=3.0)
    
    /*
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        KCSClient.shared().initializeKinveyService(
            forAppKey: "<#My App Key#>",
            withAppSecret: "<#My App Secret#>",
            usingOptions: nil
        )
        
        return true
    }
    */
    
    func dedicatedInstance() {
        let config = KCSClientConfiguration(
            appKey: "<#My App Key#>",
            secret: "<#My App Secret#>"
        )
        config?.serviceHostname = "<#My Host URL Subdomain#>" //only the subdomain, so `foo-bass` if your Host URL is `https://foo-baas.kinvey.com`
        KCSClient.shared().initialize(with: config)
    }
    
    func activeUserCheck() {
        if KCSUser.active() == nil {
            //show log-in views
        } else {
            //user is logged in and will be loaded on first call to Kinvey
        }
    }
    
    func userSignUp() {
        // Create a new user with the username 'kinvey' and the password '12345'
        KCSUser.user(
            withUsername: "kinvey",
            password: "12345",
            fieldsAndValues: nil
        ) { user, errorOrNil, result in
            if errorOrNil == nil {
                //user is created
            } else {
                //there was an error with the create
            }
        }
    }
    
    func userLogin() {
        KCSUser.login(
            withUsername: "kinvey",
            password: "12345"
        ) { user, errorOrNil, result in
            if errorOrNil == nil {
                //the log-in was successful and the user is now the active user and credentials saved
                //hide log-in view and show main app content
            } else {
                //there was an error with the login call
            }
        }
    }
    
    func micPresentViewController() {
        KCSUser.presentMICLoginViewController(withRedirectURI: "myRedirectUri://") { (user, error, actionResult) in
            if let user = user {
                //we have a valid active user
                print("User: \(user)")
            } else {
                //something went wrong!
            }
        }
    }
    
    func usingSocialAuth() {
        let accessToken = ""
        
        KCSUser.login(
            withSocialIdentity: .socialIDFacebook, //.socialIDTwitter, or .socialIDLinkedIn, or .socialIDSalesforce
            accessDictionary: [ KCSUserAccessTokenKey : accessToken ]
        ) { (user, error, actionResult) in
            if let error = error {
                //handle error
                print("Error: \(error)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        //Your App Setup...
        
        KCSClient.shared().initializeKinveyService(
            forAppKey: "<#My App Key#>",
            withAppSecret: "<#My App Secret#>",
            usingOptions: nil
        )
        
        KCSPush.registerForPush()
    
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        KCSPush.shared().application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        ) { success, error in
                //if there is an error, try again later
        }
        // Additional registration goes here (if needed)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        KCSPush.shared().application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        KCSPush.shared().registerForRemoteNotifications()
        //Additional become active actions
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        KCSPush.shared().onUnloadHelper()
        // Additional termination actions
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        KCSPush.shared().application(application, didReceiveRemoteNotification: userInfo)
        // Additional push notification handling code should be performed here
    }
    
    func appBadgeManagement() {
        //set the badge
        KCSPush.shared().setPushBadgeNumber(100) //sets to 100
        
        //clear the badge
        KCSPush.shared().resetPushBadge()
    }
    
    func initializingDataStore() {
        let collection = KCSCollection(from: "Events", of: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)!
        
        print("\(dataStore)")
    }
    
    func savingData() {
        let collection = KCSCollection(from: "Events", of: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)!
        let event = Event()
    
        dataStore.save(
            event,
            withCompletionBlock: { objectsOrNil, errorOrNil in
                if let objectsOrNil = objectsOrNil?.first as? Event {
                    //save was successful
                    print("Successfully saved event (id='\(objectsOrNil.kinveyObjectId()))').")
                } else if let errorOrNil = errorOrNil as? NSError {
                    //save failed
                    print("Save failed, with error: \(errorOrNil.localizedFailureReason)")
                }
            },
            withProgressBlock: nil
        )
    }
    
    func fetchingById() {
        let collection = KCSCollection(from: "Events", of: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)!
        let event = Event()
        
        dataStore.loadObject(
            withID: event.entityId,
            withCompletionBlock: { objectsOrNil, errorOrNil in
                if let objectsOrNil = objectsOrNil?.first {
                    print("successful reload: \(objectsOrNil)") // event updated
                } else {
                    print("error occurred: \(errorOrNil)")
                }
            },
            withProgressBlock: nil
        )
    }
    
    func fetchingByQuery() {
        let collection = KCSCollection(from: "Events", of: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)!
        
        dataStore.query(
            withQuery: KCSQuery(onField: "name", withExactMatchForValue: "Bob's birthday party" as NSString),
            withCompletionBlock: { objectsOrNil, errorOrNil in
                if errorOrNil != nil {
                    //An error happened, just log for now
                    print("An error occurred on fetch: \(errorOrNil)");
                } else {
                    //List all events
                    print("Events: \(objectsOrNil)");
                }
            },
            withProgressBlock: nil
        )
    }
    
    func deletingObject() {
        let collection = KCSCollection(from: "Events", of: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)!
        let eventToDelete = Event()
        
        dataStore.remove(
            eventToDelete,
            withDeletionBlock: { deletionDictOrNil, errorOrNil in
                if errorOrNil != nil {
                    //error occurred - add back into the list
                    print("Delete failed, with error: \(errorOrNil)")
                } else {
                    //delete successful - UI already updated
                    print("deleted response: \(deletionDictOrNil)")
                }
            },
            withProgressBlock: nil
        )
    }
    
#else
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            "<#My App Key#>",
            withAppSecret: "<#My App Secret#>",
            usingOptions: nil
        )
    
        return true
    }
    
    func dedicatedInstance() {
        let config = KCSClientConfiguration(
            appKey: "<#My App Key#>",
            secret: "<#My App Secret#>"
        )
        config.serviceHostname = "<#My Host URL Subdomain#>" //only the subdomain, so `foo-bass` if your Host URL is `https://foo-baas.kinvey.com`
        KCSClient.sharedClient().initializeWithConfiguration(config)
    }
    
    func activeUserCheck() {
        if KCSUser.activeUser() == nil {
            //show log-in views
        } else {
            //user is logged in and will be loaded on first call to Kinvey
        }
    }
    
    func userSignUp() {
        // Create a new user with the username 'kinvey' and the password '12345'
        KCSUser.userWithUsername(
            "kinvey",
            password: "12345",
            fieldsAndValues: nil
        ) { user, errorOrNil, result in
            if errorOrNil == nil {
                //user is created
            } else {
                //there was an error with the create
            }
        }
    }
    
    func userLogin() {
        KCSUser.loginWithUsername(
            "kinvey",
            password: "12345"
        ) { user, errorOrNil, result in
            if errorOrNil == nil {
                //the log-in was successful and the user is now the active user and credentials saved
                //hide log-in view and show main app content
            } else {
                //there was an error with the login call
            }
        }
    }
    
    func micPresentViewController() {
        KCSUser.presentMICLoginViewControllerWithRedirectURI("myRedirectUri://") { (user, error, actionResult) in
            if let user = user {
                //we have a valid active user
                print("User: \(user)")
            } else {
                //something went wrong!
            }
        }
    }
    
    func usingSocialAuth() {
        let accessToken = ""
        
        KCSUser.loginWithSocialIdentity(
            .SocialIDFacebook, //.SocialIDTwitter, or .SocialIDLinkedIn, or .SocialIDSalesforce
            accessDictionary: [ KCSUserAccessTokenKey : accessToken ]
        ) { (user, error, actionResult) in
            if let error = error {
                //handle error
                print("Error: \(error)")
            }
        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        //Your App Setup...
        
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            "<#My App Key#>",
            withAppSecret: "<#My App Secret#>",
            usingOptions: nil
        )
        
        KCSPush.registerForPush()
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        KCSPush.sharedPush().application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        ) { success, error in
            //if there is an error, try again later
        }
        // Additional registration goes here (if needed)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        KCSPush.sharedPush().application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        KCSPush.sharedPush().registerForRemoteNotifications()
        //Additional become active actions
    }
    
    func applicationWillTerminate(application: UIApplication) {
        KCSPush.sharedPush().onUnloadHelper()
        // Additional termination actions
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        KCSPush.sharedPush().application(application, didReceiveRemoteNotification: userInfo)
        // Additional push notification handling code should be performed here
    }
    
    func appBadgeManagement() {
        //set the badge
        KCSPush.sharedPush().setPushBadgeNumber(100) //sets to 100
        
        //clear the badge
        KCSPush.sharedPush().resetPushBadge()
    }
    
    func initializingDataStore() {
        let collection = KCSCollection(fromString: "Events", ofClass: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)
        
        print("\(dataStore)")
    }
    
    func savingData() {
        let collection = KCSCollection(fromString: "Events", ofClass: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)
        let event = Event()
        
        dataStore.saveObject(
            event,
            withCompletionBlock: { objectsOrNil, errorOrNil in
                if let objectsOrNil = objectsOrNil?.first {
                    //save was successful
                    print("Successfully saved event (id='\(objectsOrNil.kinveyObjectId())').")
                } else {
                    //save failed
                    print("Save failed, with error: \(errorOrNil.localizedFailureReason)")
                }
            },
            withProgressBlock: nil
        )
    }
    
    func fetchingById() {
        let collection = KCSCollection(fromString: "Events", ofClass: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)
        let event = Event()
        
        dataStore.loadObjectWithID(
            event.entityId,
            withCompletionBlock: { objectsOrNil, errorOrNil in
                if let objectsOrNil = objectsOrNil?.first {
                    print("successful reload: \(objectsOrNil)") // event updated
                } else {
                    print("error occurred: \(errorOrNil)")
                }
            },
            withProgressBlock: nil
        )
    }
    
    func fetchingByQuery() {
        let collection = KCSCollection(fromString: "Events", ofClass: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)
        
        dataStore.queryWithQuery(
            KCSQuery(onField: "name", withExactMatchForValue: "Bob's birthday party"),
            withCompletionBlock: { objectsOrNil, errorOrNil in
                if errorOrNil != nil {
                    //An error happened, just log for now
                    print("An error occurred on fetch: \(errorOrNil)");
                } else {
                    //List all events
                    print("Events: \(objectsOrNil)");
                }
            },
            withProgressBlock: nil
        )
    }
    
    func deletingObject() {
        let collection = KCSCollection(fromString: "Events", ofClass: Event.self)
        let dataStore = KCSAppdataStore(collection: collection, options: nil)
        let eventToDelete = Event()
        
        dataStore.removeObject(
            eventToDelete,
            withDeletionBlock: { deletionDictOrNil, errorOrNil in
                if errorOrNil != nil {
                    //error occurred - add back into the list
                    print("Delete failed, with error: \(errorOrNil)")
                } else {
                    //delete successful - UI already updated
                    print("deleted response: \(deletionDictOrNil)")
                }
            },
            withProgressBlock: nil
        )
    }
    
#endif

}

