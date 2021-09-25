//
//  VKServiceInterface.swift
//  VKClient
//
//  Created by Кирилл Копытин on 25.09.2021.
//

import Foundation
import PromiseKit

protocol VKServiceInterface {
    func getFriendsList(by userId: Int?)
    func getPhotos(by ownerId: Int)
    func getGroupsList(by userId: Int?) -> Promise<[GroupModel]>
    func getGroupsListWith(query: String, completion: @escaping ([GroupModel]) -> ())
    func getNewsfeed(startTime: Int?, startFrom: String? , completion: @escaping (String) -> ())
}
