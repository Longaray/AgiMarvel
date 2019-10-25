//
//  Items.swift
//  AgiMarvel
//
//  Created by Rodrigo on 24/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import ObjectMapper

class Items: Mappable {

    var resourceURI : String?
    var name : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        resourceURI <- map["resourceURI"]
        name        <- map["name"]
    }
}

