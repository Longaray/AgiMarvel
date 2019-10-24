//
//  Character.swift
//  AgiMarvel
//
//  Created by Rodrigo on 24/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import ObjectMapper

class Character: Mappable {

    var id = 0.0
    var thumbnail = Thumbnail()
    var name : String?
    var description : String?
    var comics = Comics()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {

        id          <- map["id"]
        thumbnail   <- map["thumbnail"]
        name        <- map["name"]
        description <- map["description"]
        comics      <- map["comics"]
    }
}
