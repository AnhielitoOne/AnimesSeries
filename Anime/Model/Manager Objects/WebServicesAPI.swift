//
//  WebServicesAPI.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/5/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation


struct WebLinks {
    
    private static let BaseUrl = "https://anilist.co/api/"
    
    static let AnimeList = BaseUrl + "browse/anime"
    static let AccesToken = BaseUrl + "auth/access_token"
    static let Search = BaseUrl + "anime/search/"
    static let Characters = BaseUrl + "anime/"
    static let CharacterInfo = BaseUrl + "character/"
    
}


class WebServicesAPI: NSObject {
    
    

    static func requestAccesToken(completionHandler:@escaping (_ succes:Bool)->()) {
        
        let params = [
            "Url Parms":"",
            "grant_type":"client_credentials",
            "client_id":"anhielito-cwbjh",
            "client_secret":"Vh0PemOgfd4aJXW7tuenqKk1EB8Pyl"
        ]
        
        Alamofire.request(WebLinks.AccesToken, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch response.result {
            case .success(let value):
                
                let jsonResponce = JSON(value)
                if let accesToken = jsonResponce["access_token"].string  {
                    User.shared.accesToken = accesToken
                    completionHandler(true)
                }
                else{
                    completionHandler(false)
                }
            
            case .failure(let error):
                print(error)
                completionHandler(false)
                
            }
        }
    }
    
    static func requestAnimeList(completionHandler:@escaping (_ succes:Bool, _ series: [Series])->()) {
        
        let Header: HTTPHeaders = [
            "Authorization": "Bearer " + User.shared.accesToken,
            "Content-Type": "application/x-www-form-urlencoded",
            ]
        
        Alamofire.request(WebLinks.AnimeList, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header).responseJSON { (response:DataResponse<Any>) in
            
            switch response.result {
            case .success(let value):
                
                let jsonResponce = JSON(value)
                if let acces = jsonResponce["error"].string  {
                    if acces == "access_denied" {
                        User.shared.accesToken = ""
                        completionHandler(false, [])
                    }
                }
                else{
                    let series = jsonResponce.arrayValue
                    var seriesCollection : [Series] = []
                    for serie in series {
                        let serieInfo = serie.dictionaryValue
                        let newSeries = Series(seriesInfo: serieInfo)
                        seriesCollection.append(newSeries)
                    }
                    completionHandler(true,seriesCollection)

                }
            
            case .failure(let error):
                print(error)
                completionHandler(false, [])

            }
        }
    }
    
    static func searchSeries(serachSeries: String, completionHandler: @escaping (_ succes:Bool, _ series: [Series])->()) {
        
        let Header: HTTPHeaders = [
            "Authorization": "Bearer " + User.shared.accesToken,
            "Content-Type": "application/x-www-form-urlencoded",
            ]
        let urlRequest = WebLinks.Search + serachSeries
        
        Alamofire.request(urlRequest, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header).responseJSON { (response:DataResponse<Any>) in
            
            switch response.result {
            case .success(let value):
                
                let jsonResponce = JSON(value)
                if let acces = jsonResponce["error"].string  {
                    if acces == "access_denied" {
                        User.shared.accesToken = ""
                        completionHandler(false, [])
                    }
                }
                else{
                    let series = jsonResponce.arrayValue
                    var seriesCollection : [Series] = []
                    for serie in series {
                        let serieInfo = serie.dictionaryValue
                        let newSeries = Series(seriesInfo: serieInfo)
                        seriesCollection.append(newSeries)
                    }
                    completionHandler(true,seriesCollection)
                    
                }
                
            case .failure(let error):
                print(error)
                completionHandler(false, [])
            }
        }
    }
    
    static func requestSeriesCharacters(seriesId: String, completionHandler: @escaping (_ succes:Bool, _ characters: [Character])->()) {
        
        let Header: HTTPHeaders = [
            "Authorization": "Bearer " + User.shared.accesToken,
            "Content-Type": "application/x-www-form-urlencoded",
            ]
        let urlRequest = WebLinks.Characters + seriesId + "/characters"
        
        Alamofire.request(urlRequest, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header).responseJSON { (response:DataResponse<Any>) in
            
            switch response.result {
            case .success(let value):
                
                let jsonResponce = JSON(value)
                if let acces = jsonResponce["error"].string  {
                    if acces == "access_denied" {
                        User.shared.accesToken = ""
                        completionHandler(false, [])
                    }
                }
                else{
                    let responce = jsonResponce.dictionaryValue
                    let characters = responce["characters"]?.arrayValue
                    var characterCollection : [Character] = []
                    for character in characters! {
                        let characterInfo = character.dictionaryValue
                        let newcharacter = Character(characterInfo: characterInfo)
                        characterCollection.append(newcharacter)
                    }
                    completionHandler(true,characterCollection)
                    
                }
                
            case .failure(let error):
                print(error)
                completionHandler(false, [])
            }
        }
    }
    
    
    static func requestCharacterInfo(characterId: String, completionHandler: @escaping (_ succes:Bool, _ character: Character?)->()) {
        
        let Header: HTTPHeaders = [
            "Authorization": "Bearer " + User.shared.accesToken,
            "Content-Type": "application/x-www-form-urlencoded",
            ]
        let urlRequest = WebLinks.CharacterInfo + characterId + "/page"
        
        Alamofire.request(urlRequest, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header).responseJSON { (response:DataResponse<Any>) in
            
            switch response.result {
            case .success(let value):
                
                let jsonResponce = JSON(value)
                print(jsonResponce)
                if let acces = jsonResponce["error"].string  {
                    if acces == "access_denied" {
                        User.shared.accesToken = ""
                        completionHandler(false,nil)
                    }
                }
                else{
                    let caracterInfo = jsonResponce.dictionaryValue
                    let newCharacter = Character(characterInfo: caracterInfo)
                    completionHandler(true,newCharacter)
                    
                }
                
            case .failure(let error):
                print(error)
                completionHandler(false,nil)
            }
        }
    }


}
