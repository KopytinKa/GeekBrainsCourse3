//
//  VKService.swift
//  VKClient
//
//  Created by Кирилл Копытин on 18.06.2021.
//

import Foundation
import Alamofire

class VKService {
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.131"
    
    let token = Session.shared.token
    
    //MARK: - Возвращает список идентификаторов друзей пользователя или расширенную информацию о друзьях пользователя (при использовании параметра fields) https://vk.com/dev/friends.get
    
    func getFriendsList(by userId: Int?, completion: @escaping (Any?) -> ()) {
        let method = "friends.get"
        
        var parameters: Parameters = [
            //"order": "name",
            //"fields": "photo_50",
            //"name_case": "nom",
            //"list_id": ,
            //"count": ,
            //"offset": ,
            //"ref": ,
            "access_token": token,
            "v": version
        ]
        
        if let userId = userId {
            parameters["user_id"] = userId
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            completion(response.value)
        }
    }
    
    //MARK: - Возвращает все фотографии пользователя или сообщества в антихронологическом порядке https://vk.com/dev/photos.getAll
    
    func getPhotos(by ownerId: Int?, completion: @escaping (Any?) -> ()) {
        let method = "photos.getAll"
        
        var parameters: Parameters = [
            //"extended": ,
            //"offset": ,
            //"count": ,
            //"photo_sizes": ,
            //"no_service_albums": ,
            //"need_hidden": ,
            //"skip_hidden": ,
            "access_token": token,
            "v": version
        ]
        
        if let ownerId = ownerId {
            parameters["ownerId"] = ownerId
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            completion(response.value)
        }
    }
    
    //MARK: - Возвращает список сообществ указанного пользователя https://vk.com/dev/groups.get
    
    func getGroupsList(by userId: Int?, completion: @escaping (Any?) -> ()) {
        let method = "groups.get"
        
        var parameters: Parameters = [
            "extended": 1,
            //"filter": ,
            //"fields": ,
            //"offset": ,
            //"count": ,
            "access_token": token,
            "v": version
        ]
        
        if let userId = userId {
            parameters["user_id"] = userId
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            completion(response.value)
        }
    }
    
    //MARK: - Осуществляет поиск сообществ по заданной подстроке https://vk.com/dev/groups.search
    
    func getGroupsListWith(query: String, completion: @escaping (Any?) -> ()) {
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
            //"count": ,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            completion(response.value)
        }
    }
}
