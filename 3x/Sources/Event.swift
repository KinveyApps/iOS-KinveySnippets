//
//  Event.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-27.
//  Copyright © 2016 Kinvey. All rights reserved.
//

#if swift(>=3.0)

import Kinvey

/// Event.swift - an entity in the 'Events' collection
class Event : Entity {
    
    var name: String?
    var date: Date?
    var location: String?
    
    override class func collectionName() -> String {
        return "Event"
    }
    
    override func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        name <- ("name", map["name"])
        date <- ("date", map["date"], KinveyDateTransform())
        location <- ("location", map["location"])
    }
}

#else

import Kinvey

/// Event.swift - an entity in the 'Events' collection
class Event : Entity {
    
    var name: String?
    var date: NSDate?
    var location: String?
    
    override class func collectionName() -> String {
        return "Event"
    }
    
    override func propertyMapping(map: Map) {
        super.propertyMapping(map)
        
        name <- ("name", map["name"])
        date <- ("date", map["date"], ISO8601DateTransform())
        location <- ("location", map["location"])
    }
}

#endif
