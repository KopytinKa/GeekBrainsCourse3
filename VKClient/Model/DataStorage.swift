//
//  DataStorage.swift
//  VKClient
//
//  Created by Кирилл Копытин on 01.06.2021.
//

import UIKit

final class DataStorage {
    static let shared = DataStorage()
    
    private init() {}
    
    var newsArray = [News]()
}
