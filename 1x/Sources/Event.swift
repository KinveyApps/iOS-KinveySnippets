//
//  Event.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-28.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Foundation

#if swift(>=3.0)

class Event : NSObject {    //all NSObjects in Kinvey implicitly implement KCSPersistable
    
    var entityId: String? //Kinvey entity _id
    var name: String?
    var date: NSDate?
    var location: String?
    var metadata: KCSMetadata? //Kinvey metadata, optional
    
    override func hostToKinveyPropertyMapping() -> [AnyHashable : Any]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "date" : "date",
            "location" : "location",
            "metadata" : KCSEntityKeyMetadata //optional _metadata field
        ]
    }
    
}

#else

class Event : NSObject {    //all NSObjects in Kinvey implicitly implement KCSPersistable
    
    var entityId: String? //Kinvey entity _id
    var name: String?
    var date: NSDate?
    var location: String?
    var metadata: KCSMetadata? //Kinvey metadata, optional
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "date" : "date",
            "location" : "location",
            "metadata" : KCSEntityKeyMetadata //optional _metadata field
        ]
    }
    
}

#endif
