//
//  Post.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 24/08/22.
//

import Foundation
import RealmSwift

class Post: Object, Codable {
    
    @objc dynamic var id: Int
    @objc dynamic var title: String
    @objc dynamic var body: String
    @objc dynamic var userId: Int
    dynamic var isFavorite: Bool? = false
    
    

    // MARK: - Dynamic properties
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toggleFavorite() {
        guard let favoState = isFavorite else { return }
        try? realm?.write{
            isFavorite = !favoState
        }
    }
    
    convenience init(id: Int, title: String, body: String, userId: Int, isFavorite: Bool? = false) {
        self.init()
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
        self.isFavorite = isFavorite
    }
}
