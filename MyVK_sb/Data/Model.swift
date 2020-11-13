//
//  Model.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import Foundation

// MARK: - Session singleton

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
}

// MARK: - CellsIds

struct CellIds {
    static let tableCell = "DefaulCell"
    static let collectionCell = "FotoCell"
    static let newsCell = "NewsCell"
}

// MARK: - Groups

struct Groups {
    static let names = ["Jokes", "Louis", "News", "Transnigers"]
    static let images = ["jokes", "louis", "news", "nigers"]
}

// MARK: - Friends

struct Data {
    static let names = ["A Maul", "B Malak", "C Bane", "Darth Vader", "Darth Kreo", "Sidious", "Alex", "Bob"]
    static let avatars = ["maul", "malak", "bane"]
}

struct Object: Equatable {
    let name: String
    let avatar: String
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
}
