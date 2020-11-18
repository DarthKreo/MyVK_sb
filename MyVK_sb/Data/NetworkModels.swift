//
//  NetworkModels.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 16.11.2020.
//

import Foundation
import SwiftyJSON

// MARK: - Friend

class Friend {
    let firstName: String
    let lastName: String
    let id: Int
    let photo: String
    
    // MARK: - Init
    
    init(json: JSON) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.id = json["id"].intValue
        self.photo = json["photo_50"].stringValue
    }
}

// MARK: - Group

class Group {
    let name: String
    let id: Int
    let photo: String
    
    // MARK: - Init
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].intValue
        self.photo = json["photo_50"].stringValue
    }
}

// MARK: - Photo

class Photo {
    let id: Int
    let url: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.url = json["sizes"][1]["url"].stringValue
    }
}
