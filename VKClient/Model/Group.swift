//
//  Group.swift
//  VKClient
//
//  Created by Кирилл Копытин on 20.05.2021.
//

import UIKit

struct Group {
    var name: String
    var avatar: UIImage?
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}
