//
//  Series.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/5/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import SwiftyJSON

class Series: NSObject {
    
    var id : Int?
    var seriesType : String?
    var titleRomaji : String?
    var titleEnglish : String?
    var titleJapanese : String?
    var type : String?
    var startDateFuzzy : Int?
    var endDateFuzzy : Int?
    var season : Int?
    var descriptionSerie : String?
    var synonyms : [String]?
    var genres : [String]?
    var adult : Bool?
    var avarageScore : Double?
    var popularity : Int?
    var favourite : Bool?
    var imageUrlSml : String?
    var imagUrlMed : String?
    var imageUrlLge : String?
    var imageUrlBanner : String?
    var updatedAt : Int?
    var airingStatus : String?
    var totalEpisodes : Int?

    override init() {
        
    }
    
    init(seriesInfo:[String:Any]) {
        
        let info = JSON(seriesInfo)
        self.id = info["id"].intValue
        self.seriesType = info["series_type"].stringValue
        self.titleRomaji = info["title_romaji"].stringValue
        self.titleEnglish = info["title_english"].stringValue
        self.titleJapanese = info["title_japanese"].stringValue
        self.type = info["type"].stringValue
        self.startDateFuzzy = info["start_date_fuzzy"].intValue
        self.endDateFuzzy = info["end_date_fuzzy"].intValue
        self.season = info["season"].intValue
        self.descriptionSerie = info["description"].stringValue
        self.synonyms = info["synonyms"].arrayValue.map { $0.stringValue}
        self.genres = info["genres"].arrayValue.map { $0.stringValue}
        self.adult = info["adult"].boolValue
        self.avarageScore = info["average_score"].doubleValue
        self.popularity = info["popularity"].intValue
        self.favourite = info["favourite"].boolValue
        self.imageUrlSml = info["image_url_sml"].stringValue
        self.imagUrlMed = info["image_url_med"].stringValue
        self.imageUrlLge = info["image_url_lge"].stringValue
        self.imageUrlBanner = info["image_url_banner"].stringValue
        self.updatedAt = info["updated_at"].intValue
        self.airingStatus = info["airing_status"].stringValue
        self.totalEpisodes = info["total_episodes"].intValue

    }
    
}
