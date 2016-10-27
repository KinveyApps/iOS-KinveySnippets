//
//  CustomUser.swift
//  KinveySnippet
//
//  Created by Victor Hugo on 2016-10-25.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Kinvey

#if swift(>=3.0)

class CustomUser: User {
    
    var address: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        address <- map["address"]
    }
}

#else

class CustomUser: User {
    
    var address: String?
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        address <- map["address"]
    }
}

#endif
