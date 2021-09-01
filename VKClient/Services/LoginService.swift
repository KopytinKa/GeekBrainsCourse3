//
//  LoginService.swift
//  VKClient
//
//  Created by Кирилл Копытин on 17.08.2021.
//

import Foundation

class LoginService {
    let correctLogin = "a"
    let correctPassword = "a"
    
    func checkUserData(login: String, password: String) -> Bool {
        if login == correctLogin && password == correctPassword {
            return true
        } else {
            return false
        }
    }
}
