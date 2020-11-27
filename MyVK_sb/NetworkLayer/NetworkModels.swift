//
//  NetworkModels.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 16.11.2020.
//

import SwiftyJSON
import RealmSwift

// MARK: - Friend

class Friend: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String = ""
    //let photos = List<Photo>()
    
    // MARK: - Init
    
    convenience init(json: JSON) {
        self.init()
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.id = json["id"].intValue
        self.photo = json["photo_50"].stringValue
        //self.photos.append(objectsIn: photos)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Group

class Group: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String = ""
    
    // MARK: - Init
    
    convenience init(json: JSON) {
        self.init()
        self.name = json["name"].stringValue
        self.id = json["id"].intValue
        self.photo = json["photo_50"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Photo

class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var url: String = ""
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.url = json["sizes"][1]["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
