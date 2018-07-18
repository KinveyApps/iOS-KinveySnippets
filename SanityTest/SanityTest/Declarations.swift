//
//  Book.swift
//  SanityTest
//
//  Created by Victor Hugo Carvalho Barros on 2018-06-15.
//  Copyright © 2018 Kinvey. All rights reserved.
//

import Kinvey
import CoreLocation

class Book: Entity {
    
}

class Person: Entity {
    
}

class Event: Entity {
    
    @objc dynamic var title: String?
    @objc dynamic var geolocation: GeoPoint?
    @objc dynamic var address: String?
    
    override class func collectionName() -> String {
        return "Event"
    }
    
    @available(*, deprecated, message: "Please use Swift.Codable instead")
    override func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        title <- ("title", map["title"])
        geolocation <- ("geolocation", map["geolocation"])
        address <- ("address", map["address"])
    }
    
}

class CustomUser: User {
    
    @objc dynamic var geolocation: GeoPoint?
    @objc dynamic var address: String?
    
}

class MyFile: File {
    
    @objc
    dynamic var label: String?
    
    @available(*, deprecated, message: "Please use Swift.Codable instead")
    public convenience required init?(map: Map) {
        self.init(map: map)
    }
    
    @available(*, deprecated, message: "Please use Swift.Codable instead")
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        label <- ("label", map["label"])
    }
    
}

let book = Book()
let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
let dataStore = try! DataStore<Book>.collection()
let query = Query()
let redirect = URL(string: "")!
let url = URL(string: "")!
let facebookDictionary: [String : Any] = [:]
let fileStore = FileStore()
let file = File()
let event = Event()
let username = ""
let password = ""
let user = User()

extension CodeSnippets: CLLocationManagerDelegate {
    
}

func printAny(_ any: Any?) {
    print(any ?? "")
}
