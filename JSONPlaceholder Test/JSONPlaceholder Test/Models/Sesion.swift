//
//  Sesion.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 24/08/22.
//

import Foundation
import RealmSwift

class Sesion: Object {
    
    // MARK: - Properties
    @objc dynamic var name = ""
    @objc dynamic var numberOfPost = 0
    
    // MARK: - Collections
    let postList = List<Post>()
    let outgoingPostList = List<Post>()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    private static func createDefaultUser(in realm: Realm) -> Sesion {
        let me = Sesion(name: "me")
        try! realm.write {
            realm.add(me)
        }
        return me
    }
    
    @discardableResult
    static func defaultUser(in realm: Realm) -> Sesion {
        return realm.object(ofType: Sesion.self, forPrimaryKey: "me")
        ?? createDefaultUser(in: realm)
    }
}
