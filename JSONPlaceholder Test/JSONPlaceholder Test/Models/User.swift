//
//  User.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 28/08/22.
//

import Foundation


struct User: Codable {
    let id: Int
    let name: String
    let userName: String
    let email: String
    let address: Addres
    let phone: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case email
        case address
        case phone
        case website
    }
}

struct Addres: Codable {
    let street: String
    let suite: String
    let city: String
    let zipCode: String
    let geolocalization: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipCode = "zipcode"
        case geolocalization = "geo"
    }
}

struct Coordinates: Codable {
    let lat: String
    let lng: String
}
