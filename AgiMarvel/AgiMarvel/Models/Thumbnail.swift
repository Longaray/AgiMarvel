//
//  Thumbnail.swift
//  AgiMarvel
//
//  Created by Rodrigo on 24/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import ObjectMapper

class Thumbnail: Mappable {

    var ext : String?
    var path : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        ext  <- map["extension"]
        path <- map["path"]
    }
}
