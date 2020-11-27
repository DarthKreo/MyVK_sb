//
//  RealmProvider.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.11.2020.
//

import RealmSwift

class RealmProvider {
    
    static func save<T: Object>(items: [T], config: Realm.Configuration) {
        print(config.fileURL ?? "link")
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(items, update: Realm.UpdatePolicy.modified)
            }
        } catch {
            print(error)
        }
    }
    
    static func load<T: Object>(_ type: T.Type,
                                config: Realm.Configuration) throws -> Results<T> {
            let realm = try Realm(configuration: config)
            return realm.objects(type)
    }
    
    static func delete<T: Object>(_ items: [T],
                                  config: Realm.Configuration) {
        let realm = try? Realm(configuration: config)
        try? realm?.write {
            realm?.delete(items)
        }
    }
}


