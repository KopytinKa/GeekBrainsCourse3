//
//  Friend.swift
//  VKClient
//
//  Created by Кирилл Копытин on 23.06.2021.
//

import UIKit

struct Friends: Codable {
    let response: Response
}

struct Response: Codable {
    let count: Int
    let items: [Friend]
}

struct Friend: Codable {
    let id: Int
    let lastName: String
    let firstName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case avatar = "photo_50"
    }
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
