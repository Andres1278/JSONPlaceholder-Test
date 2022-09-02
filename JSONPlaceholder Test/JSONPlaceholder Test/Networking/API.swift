//
//  API.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 26/08/22.
//

import Foundation
import Alamofire

struct API {
    
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let queryParameterKey = "query"
    static let pageParameterKey = "page"
    
    enum Endpoint {
        case albums(id: Int)
        case comments(id: Int)
        case photos(id: Int)
        case postDetail(id:Int)
        case postListByUser(id: Int)
        case todos
        case users(userId: Int)
        
        var path: String {
            switch self {
            case .albums(let id): return "/users/\(id)/albums"
            case .comments(let id): return "/posts/\(id)/comments"
            case .photos(let id): return "/albums/\(id)/photos"
            case .postListByUser(let id): return "/users/\(id)/posts"
            case .postDetail(let id): return "/posts/\(id)"
            case .todos: return "/todos"
            case .users(let id): return "/users/\(id)"
            }
        }
    }
    
    static func url(for endpoint: Endpoint) -> String {
        return baseURL + endpoint.path
    }
}

