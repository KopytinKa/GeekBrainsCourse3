//
//  VKService.swift
//  VKClient
//
//  Created by Кирилл Копытин on 18.06.2021.
//

import Foundation
import Alamofire
import DynamicJSON

class VKService {
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.131"
    let realmService = RealmService()
    
    //MARK: - Возвращает список идентификаторов друзей пользователя или расширенную информацию о друзьях пользователя (при использовании параметра fields) https://vk.com/dev/friends.get
    
    func getFriendsList(by userId: Int?, completion: @escaping () -> ()) {
        let method = "friends.get"
        
        var parameters: Parameters = [
            //"order": "name",
            "fields": "photo_50",
            //"name_case": "nom",
            //"list_id": ,
            //"count": "100",
            //"offset": ,
            //"ref": ,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        if let userId = userId {
            parameters["user_id"] = userId
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            guard let self = self else { return }
            guard let data = response.value else { return }
            guard let items = JSON(data).response.items.array else { return }

            let friends = items.map { UserModel(data: $0) }
            
            self.realmService.add(models: friends)
            
            completion()
        }
    }
    
    //MARK: - Возвращает список фотографий в альбоме https://vk.com/dev/photos.get
    
    func getPhotos(by ownerId: Int, completion: @escaping () -> ()) {
        let method = "photos.get"
        
        let parameters: Parameters = [
            "user_id": ownerId,
            "extended": 1,
            "album_id": "profile",
            //"photo_ids": ,
            "rev": 1,
            //"feed_type": ,
            //"feed": ,
            //"offset": ,
            "count": "10",
            //"photo_sizes": ,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            guard let self = self else { return }
            guard let data = response.value else { return }
            guard let items = JSON(data).response.items.array else { return }

            let photos = items.map { PhotoModel(data: $0) }
            
            self.realmService.add(models: photos)
            
            completion()
        }
    }
    
    //MARK: - Возвращает список сообществ указанного пользователя https://vk.com/dev/groups.get
    
    func getGroupsList(by userId: Int?, completion: @escaping () -> ()) {
        let method = "groups.get"
        
        var parameters: Parameters = [
            "extended": 1,
            //"filter": "publics",
            //"fields": ,
            //"offset": ,
            //"count": ,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        if let userId = userId {
            parameters["user_id"] = userId
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            guard let self = self else { return }
            guard let data = response.value else { return }
            guard let items = JSON(data).response.items.array else { return }

            let groups = items.map { GroupModel(data: $0) }
            
            self.realmService.add(models: groups)
            
            completion()
        }
    }
    
    //MARK: - Осуществляет поиск сообществ по заданной подстроке https://vk.com/dev/groups.search
    
    func getGroupsListWith(query: String, completion: @escaping ([GroupModel]) -> ()) {
        let method = "groups.search"
        
        let parameters: Parameters = [
            "q": query,
            //"type": ,
            //"country_id": ,
            //"city_id": ,
            //"future": ,
            //"market": ,
            //"sort": ,
            //"offset": ,
            "count": "100",
            "access_token": Session.shared.token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            guard let items = JSON(data).response.items.array else { return }

            let groups = items.map { GroupModel(data: $0) }
            
            DispatchQueue.main.async {
                completion(groups)
            }
        }
    }
}
