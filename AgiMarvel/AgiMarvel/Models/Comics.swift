//
//  Comics.swift
//  AgiMarvel
//
//  Created by Rodrigo on 24/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import ObjectMapper

class Comics: Mappable {

    var items = [Items]()
    var collectionURI : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        items           <- map["items"]
        collectionURI   <- map["collectionURI"]
    }
}


