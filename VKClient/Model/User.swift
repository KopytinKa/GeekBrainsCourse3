//
//  User.swift
//  VKClient
//
//  Created by Кирилл Копытин on 07.09.2021.
//

import Foundation

struct User {
    let id: Int
    let lastName: String
    let firstName: String
    let avatar: String
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
