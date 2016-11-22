//
//  Event.m
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-28.
//  Copyright © 2016 Kinvey. All rights reserved.
//

#import "Event.h"

@implementation Event

- (NSDictionary *)hostToKinveyPropertyMapping
{
    return @{
             @"entityId" : KCSEntityKeyId, //the required _id field
             @"name" : @"name",
             @"date" : @"date",
             @"location" : @"location",
             @"metadata" : KCSEntityKeyMetadata //optional _metadata field
             };
}

@end
