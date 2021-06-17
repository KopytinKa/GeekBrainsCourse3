//
//  User.swift
//  VKClient
//
//  Created by Кирилл Копытин on 20.05.2021.
//

import UIKit

struct User {
    var firstName: String
    var secondName: String
    var photos: [UIImage]?
    var avatar: UIImage?
    
    func getFullName() -> String {
        return "\(firstName) \(secondName)"
    }
}
