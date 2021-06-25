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
    
    //MARK: - Возвращает список идентификаторов друзей пользователя или расширенную информацию о друзьях пользователя (при использовании параметра fields) https://vk.com/dev/friends.get
    
    func getFriendsList(by userId: Int?, completion: @escaping ([Friend]) -> ()) {
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
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data).response
            guard let friends = friendsResponse?.items else { return }
            DispatchQueue.main.async {
                completion(friends)
            }
        }
    }
    
    //MARK: - Возвращает все фотографии пользователя или сообщества в антихронологическом порядке https://vk.com/dev/photos.getAll
    
    func getPhotos(by ownerId: Int?, completion: @escaping (Any?) -> ()) {
        let method = "photos.getAll"
        
        var parameters: Parameters = [
            "extended": 1,
            //"offset": ,
            //"count": ,
            //"photo_sizes": ,
            "no_service_albums": 1,
            //"need_hidden": ,
            //"skip_hidden": ,
            "access_token": Session.shared.token,
            "v": version
        ]
        
        if let ownerId = ownerId {
            parameters["ownerId"] = ownerId
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            guard let data = response.value else { return }
            completion(data)
        }
    }
    
    //MARK: - Возвращает список сообществ указанного пользователя https://vk.com/dev/groups.get
    
    func getGroupsList(by userId: Int?, completion: @escaping ([Group]) -> ()) {
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
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data).response
            guard let groups = groupsResponse?.items else { return }
            DispatchQueue.main.async {
                completion(groups)
            }
        }
    }
    
    //MARK: - Осуществляет поиск сообществ по заданной подстроке https://vk.com/dev/groups.search
    
    func getGroupsListWith(query: String, completion: @escaping ([Group]) -> ()) {
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
            let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data).response
            guard let groups = groupsResponse?.items else { return }
            DispatchQueue.main.async {
                completion(groups)
            }
        }
    }
}
