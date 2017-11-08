//
//  User.swift
//  Anime
//
//  Created by Angel Coronado Quintero on 11/5/17.
//  Copyright © 2017 Angel Coronado Quintero. All rights reserved.
//

import UIKit

class User: NSObject {
    
    // Can't init is singleton
    private override init() {
        
    }
    
    // MARK: Shared Instance
    
    static let shared = User()
    
    var accesToken : String {
        get {
            //To retrieve from the key
            let userDefaults = Foundation.UserDefaults.standard
            if let value : String = userDefaults.string(forKey: "accesToken") {
                return value
            }
            else{
                return ""
            }
        }
        
        set {
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set( newValue, forKey: "accesToken")
            
        }
        
    }

}
