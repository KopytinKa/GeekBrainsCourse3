//
//  Friend.swift
//  VKClient
//
//  Created by Кирилл Копытин on 23.06.2021.
//

import Foundation
import RealmSwift

struct Groups: Codable {
    let response: ResponseGroups
}

struct ResponseGroups: Codable {
    let count: Int
    let items: [Group]
}

class Group: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        
        if let other = object as? Group {
            return self.id == other.id
        }

        return false

    }
}
