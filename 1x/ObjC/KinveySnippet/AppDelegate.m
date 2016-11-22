//
//  AppDelegate.m
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-25.
//  Copyright © 2016 Kinvey. All rights reserved.
//

#import "AppDelegate.h"

#import <KinveyKit/KinveyKit.h>
#import "Event.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[KCSClient sharedClient] initializeKinveyServiceForAppKey:@"<#My App Key#>"
                                                 withAppSecret:@"<#My App Secret#>"
                                                  usingOptions:nil];
    
    return YES;
}
*/

-(void)dedicatedInstance
{
    KCSClientConfiguration* config = [KCSClientConfiguration configurationWithAppKey:@"<#My App Key#>"
                                                                              secret:@"<#My App Secret#>"];
    config.serviceHostname = @"<#My Host URL Subdomain#>"; //only the subdomain, so `foo-bass` if your Host URL is `https://foo-baas.kinvey.com`
    [[KCSClient sharedClient] initializeWithConfiguration:config];
}

-(void)activeUserCheck
{
    if (![KCSUser activeUser]) {
        //show log-in views
    } else {
        //user is logged in and will be loaded on first call to Kinvey
    }
}

-(void)userSignUp
{
    // Create a new user with the username 'kinvey' and the password '12345'
    [KCSUser userWithUsername:@"kinvey" password:@"12345" fieldsAndValues:nil withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
        if (errorOrNil == nil) {
            //user is created
        } else {
            //there was an error with the create
        }
    }];
}

-(void)userLogin
{
    [KCSUser loginWithUsername:@"kinvey" password:@"12345" withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
        if (errorOrNil ==  nil) {
            //the log-in was successful and the user is now the active user and credentials saved
            //hide log-in view and show main app content
        } else {
            //there was an error with the login call
        }
    }];
}

-(void)micPresentViewController
{
    [KCSUser presentMICLoginViewControllerWithRedirectURI:@"myRedirectUri://"
                                      withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result)
    {
        if (user) {
            //we have a valid active user
        } else {
            //something went wrong!
        }
    }];
}

-(void)usingSocialAuth
{
    NSString* accessToken;
    
    [KCSUser loginWithSocialIdentity:KCSSocialIDFacebook //or KCSSocialIDTwitter, or KCSSocialIDLinkedIn, or KCSSocialIDSalesforce
                    accessDictionary:@{ KCSUserAccessTokenKey : accessToken }
                 withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
        if (errorOrNil) {
            //handle error
        }
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Your App Setup...
    
    [[KCSClient sharedClient] initializeKinveyServiceForAppKey:@"<#My App Key#>"
                                                 withAppSecret:@"<#My App Secret#>"
                                                  usingOptions:nil];
    
    //Start push service
    [KCSPush registerForPush];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[KCSPush sharedPush] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken completionBlock:^(BOOL success, NSError *error) {
        //if there is an error, try again later
    }];
    // Additional registration goes here (if needed)
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[KCSPush sharedPush] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[KCSPush sharedPush] registerForRemoteNotifications];
    //Additional become active actions
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[KCSPush sharedPush] onUnloadHelper];
    // Additional termination actions
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[KCSPush sharedPush] application:application didReceiveRemoteNotification:userInfo];
    // Additional push notification handling code should be performed here
}

-(void)appBadgeManagement
{
    //set the badge
    [[KCSPush sharedPush] setPushBadgeNumber:100]; //sets to 100
    
    //clear the badge
    [[KCSPush sharedPush] resetPushBadge];
}

-(void)initializingDataStore
{
    KCSCollection* collection = [KCSCollection collectionFromString:@"Events"
                                                            ofClass:[Event class]];
    KCSAppdataStore* dataStore = [KCSAppdataStore storeWithCollection:collection
                                                              options:nil];
    
    NSLog(@"%@", dataStore);
}

-(void)savingData
{
    KCSCollection* collection = [KCSCollection collectionFromString:@"Events"
                                                            ofClass:[Event class]];
    KCSAppdataStore* dataStore = [KCSAppdataStore storeWithCollection:collection
                                                              options:nil];
    Event* event;
    
    [dataStore saveObject:event
      withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
            if (errorOrNil != nil) {
                //save failed
                NSLog(@"Save failed, with error: %@", [errorOrNil localizedFailureReason]);
            } else {
                //save was successful
                NSLog(@"Successfully saved event (id='%@').", [objectsOrNil[0] kinveyObjectId]);
            }
    } withProgressBlock:nil];
}

-(void)fetchingById
{
    KCSCollection* collection = [KCSCollection collectionFromString:@"Events"
                                                            ofClass:[Event class]];
    KCSAppdataStore* dataStore = [KCSAppdataStore storeWithCollection:collection
                                                              options:nil];
    Event* event;
    
    [dataStore loadObjectWithID:event.entityId withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        if (errorOrNil == nil) {
            NSLog(@"successful reload: %@", objectsOrNil[0]); // event updated
        } else {
            NSLog(@"error occurred: %@", errorOrNil);
        }
    } withProgressBlock:nil];
}

-(void)fetchingByQuery
{
    KCSCollection* collection = [KCSCollection collectionFromString:@"Events"
                                                            ofClass:[Event class]];
    KCSAppdataStore* dataStore = [KCSAppdataStore storeWithCollection:collection
                                                              options:nil];
    
    [dataStore queryWithQuery:[KCSQuery queryOnField:@"name" withExactMatchForValue:@"Bob's birthday party"]
          withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        if (errorOrNil != nil) {
            //An error happened, just log for now
            NSLog(@"An error occurred on fetch: %@", errorOrNil);
        } else {
            //List all events
            NSLog(@"Events: %@", objectsOrNil);
        }
    } withProgressBlock:nil];
}

-(void)deletingObject
{
    KCSCollection* collection = [KCSCollection collectionFromString:@"Events"
                                                            ofClass:[Event class]];
    KCSAppdataStore* dataStore = [KCSAppdataStore storeWithCollection:collection
                                                              options:nil];
    Event* eventToDelete;
    
    [dataStore removeObject:eventToDelete withDeletionBlock:^(NSDictionary* deletionDictOrNil, NSError *errorOrNil) {
        if (errorOrNil) {
            //error occurred - add back into the list
            NSLog(@"Delete failed, with error: %@ ", errorOrNil);
        } else {
            //delete successful - UI already updated
            NSLog(@"deleted response: %@", deletionDictOrNil);
        }
    } withProgressBlock:nil];
}

@end
