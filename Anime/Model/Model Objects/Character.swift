//
//  Character.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/7/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import SwiftyJSON

class Character: NSObject {
    
    var nameAlt : String?
    var info : String?
    var id : Int?
    var nameFirst : String?
    var nameLast : String?
    var nameJapanese : String?
    var imageUrlLge : String?
    var imageUrlMed : String?
    var favourite : Bool?
    
    override init() {
        
    }
    
    init(characterInfo:[String:Any]) {
        
        let info = JSON(characterInfo)
        self.nameAlt = info["name_alt"].stringValue
        self.info = info["info"].stringValue
        self.id = info["id"].intValue
        self.nameFirst = info["name_first"].stringValue
        self.nameLast = info["name_last"].stringValue
        self.nameJapanese = info["name_japanese"].stringValue
        self.imageUrlLge = info["image_url_lge"].stringValue
        self.imageUrlMed = info["image_url_med"].stringValue
        self.favourite = info["favourite"].boolValue

    }
}
