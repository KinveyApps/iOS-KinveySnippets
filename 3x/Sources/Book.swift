//
//  Book.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-25.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Kinvey
    
#if swift(>=3.0)
    
class Book: Entity {
    
    dynamic var title: String?
    dynamic var authorName: String?
    
    override class func collectionName() -> String {
        //return the name of the backend collection corresponding to this entity
        return "Book"
    }
    
    //Map properties in your backend collection to the members of this entity
    override func propertyMapping(_ map: Map) {
        //This maps the "_id", "_kmd" and "_acl" properties
        super.propertyMapping(map)
    
        //Each property in your entity should be mapped using the following scheme:
        //<member variable> <- ("<backend property>", map["<backend property>"])
        title <- ("title", map["title"])
        authorName <- ("authorName", map["author"])
    }
}
    
class Book2: Entity {
    
    override class func collectionName() -> String {
        //return the name of the backend collection corresponding to this entity
        return "Book2"
    }
    
    //the following code shows how to map a NSDate property in the "Book" entity using a date transform
    dynamic var publishDate: Date?
    
    override func propertyMapping(_ map: Map) {
        //This maps the "_id", "_kmd" and "_acl" properties
        super.propertyMapping(map)
    
        //this maps the backend property "date" to the member variable "publishDate" using a ISO 8601 date transform
        publishDate <- ("publishDate", map["date"], ISO8601DateTransform())
    }
}

#else
    
class Book: Entity {
    
    dynamic var title: String?
    dynamic var authorName: String?
    
    override class func collectionName() -> String {
        //return the name of the backend collection corresponding to this entity
        return "Book"
    }
    
    //Map properties in your backend collection to the members of this entity
    override func propertyMapping(map: Map) {
        //This maps the "_id", "_kmd" and "_acl" properties
        super.propertyMapping(map)
        
        //Each property in your entity should be mapped using the following scheme:
        //<member variable> <- ("<backend property>", map["<backend property>"])
        title <- ("title", map["title"])
        authorName <- ("authorName", map["author"])
    }
}
    
class Book2: Entity {
    
    override class func collectionName() -> String {
        //return the name of the backend collection corresponding to this entity
        return "Book2"
    }
    
    //the following code shows how to map a NSDate property in the "Book" entity using a date transform
    dynamic var publishDate: NSDate?
    
    override func propertyMapping(map: Map) {
        //This maps the "_id", "_kmd" and "_acl" properties
        super.propertyMapping(map)
    
        //this maps the backend property "date" to the member variable "publishDate" using a ISO 8601 date transform
        publishDate <- ("publishDate", map["date"], ISO8601DateTransform())
    }
}

#endif
