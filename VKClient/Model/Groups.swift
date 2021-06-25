//
//  Friend.swift
//  VKClient
//
//  Created by Кирилл Копытин on 23.06.2021.
//

import Foundation

struct Groups: Codable {
    let response: ResponseGroups
}

struct ResponseGroups: Codable {
    let count: Int
    let items: [Group]
}

struct Group: Codable {
    let id: Int
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}
