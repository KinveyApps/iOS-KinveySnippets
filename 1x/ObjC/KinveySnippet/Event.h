//
//  Event.h
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-28.
//  Copyright © 2016 Kinvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

@interface Event : NSObject <KCSPersistable>

@property (nonatomic, copy) NSString* entityId; //Kinvey entity _id
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSDate* date;
@property (nonatomic, copy) NSString* location;
@property (nonatomic, retain) KCSMetadata* metadata; //Kinvey metadata, optional

@end
