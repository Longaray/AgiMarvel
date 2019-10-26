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
    
    private let urlCharacters = "http://gateway.marvel.com/v1/public/characters"
    private let apiKey = "ecce9fda28689a8e2ae61acd49035574"
    private let privateKey = "ef9c3be04c504c1b4fbd8fe7ad85fda97700da08"
    
    //func  header
    //Retrive all marvel characters
    func getCharacters(offset:String, completionHandler: @escaping ([Character]?,Error?) -> Void)
    {
        
        let timeStamp = (NSNumber(value: Date().timeIntervalSince1970)).stringValue
        
        let hash = (timeStamp + privateKey + apiKey).md5()
        
        let parameters = [
            "apikey": apiKey,
            "ts": timeStamp,
            "hash": hash,
            "offset": offset
        ]
        
        Alamofire.request(urlCharacters, method: .get, parameters: parameters).responseJSON { (responseData) -> Void in
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
    
    func getTotalCharacters(completionHandler: @escaping (Int,Error?) -> Void)
    {
        
        let timeStamp = (NSNumber(value: Date().timeIntervalSince1970)).stringValue
        
        let hash = (timeStamp + privateKey + apiKey).md5()
        
        let parameters = [
            "apikey": apiKey,
            "ts": timeStamp,
            "hash": hash
        ]
        
        Alamofire.request(urlCharacters, method: .get, parameters: parameters).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                let data = swiftyJsonVar["data"]
                let total = data["total"]
                //print(swiftyJsonVar)
                completionHandler(total.intValue,nil)
            }
        }
    }
    
}
