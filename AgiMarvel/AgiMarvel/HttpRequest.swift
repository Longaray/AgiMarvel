//
//  HttpRequest.swift
//  AgiMarvel
//
//  Created by Rodrigo on 24/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
import Alamofire
import SwiftyJSON
import CryptoSwift

class HttpRequest: NSObject {

    //Retrive all marvel characters
    func getCharacters(completionHandler: @escaping ([Character]?,Error?) -> Void)
    {
        
        let urlEventos = "http://gateway.marvel.com/v1/public/characters"
        let apiKey = "ecce9fda28689a8e2ae61acd49035574"
        let privateKey = "ef9c3be04c504c1b4fbd8fe7ad85fda97700da08"
        let timeStamp = (NSNumber(value: Date().timeIntervalSince1970)).stringValue
        
        let hash = (timeStamp + privateKey + apiKey).md5()
        
        let parameters = [
            "apikey": apiKey,
            "ts": timeStamp,
            "hash": hash
        ]
        
        Alamofire.request(urlEventos, method: .get, parameters: parameters).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                let data = swiftyJsonVar["data"]
                let result = data["results"]
                let characters = Mapper<Character>().mapArray(JSONString: result.description)
                //print(swiftyJsonVar)
                completionHandler(characters,nil)
            }
        }
    }
    
}
