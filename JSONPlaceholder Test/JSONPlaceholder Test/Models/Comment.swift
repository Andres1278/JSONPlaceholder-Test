//
//  Comment.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 28/08/22.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
