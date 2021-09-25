//
//  VKServiceProxy.swift
//  VKClient
//
//  Created by Кирилл Копытин on 25.09.2021.
//

import Foundation
import PromiseKit

class VKServiceProxy: VKServiceInterface {
    let apiVKService: VKService
    
    init(_ service: VKService) {
        self.apiVKService = service
    }

    func getFriendsList(by userId: Int?) {
        print("Логирование запроса: Получение списка друзей")
        print("Параметры: userId = \(userId ?? 0)")
        
        self.apiVKService.getFriendsList(by: userId)
    }
    
    func getPhotos(by ownerId: Int) {
        print("Логирование запроса: Получение списка фото")
        print("Параметры: ownerId = \(ownerId)")
        
        self.getPhotos(by: ownerId)
    }
    
    func getGroupsList(by userId: Int?) -> Promise<[GroupModel]> {
        print("Логирование запроса: Получение списка групп")
        print("Параметры: userId = \(userId ?? 0)")
        
        return self.apiVKService.getGroupsList(by: userId)
    }
    
    func getGroupsListWith(query: String, completion: @escaping ([GroupModel]) -> ()) {
        print("Логирование запроса: Получение списка групп по запросу")
        print("Параметры: query = \(query)")
        
        self.apiVKService.getGroupsListWith(query: query, completion: completion)
    }
    
    func getNewsfeed(startTime: Int? = nil, startFrom: String? = nil, completion: @escaping (String) -> ()) {
        print("Логирование запроса: Получение списка новостей")
        print("Параметры: startTime = \(startTime ?? 0), startFrom = \(startFrom ?? "")")
        
        self.apiVKService.getNewsfeed(startTime: startTime, startFrom: startFrom, completion: completion)
    }
}
