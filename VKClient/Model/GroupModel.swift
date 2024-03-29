//
//  GroupModel.swift
//  VKClient
//
//  Created by Кирилл Копытин on 30.06.2021.
//

import Foundation
import DynamicJSON
import RealmSwift

class GroupModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var avatar = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init(data: JSON) {
        self.init()

        self.id = data.id.int ?? 0
        self.name = data.name.string ?? ""
        self.avatar = data.photo_50.string ?? ""
    }
    
    convenience required init(group: Group) {
        self.init()

        self.id = group.id
        self.name = group.name
        self.avatar = group.avatar
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        
        if let other = object as? GroupModel {
            return self.id == other.id
        }

        return false

    }
}
