//
//  Session.swift
//  VKClient
//
//  Created by Кирилл Копытин on 17.06.2021.
//

import Foundation

final class Session {
    static let shared = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: String = ""
}
