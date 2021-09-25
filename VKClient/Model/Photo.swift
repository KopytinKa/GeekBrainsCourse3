//
//  Photo.swift
//  VKClient
//
//  Created by Кирилл Копытин on 07.09.2021.
//

import Foundation

struct Photo {
    let id: Int
    let albumID: Int
    let ownerID: Int
    let urlByPhoto: String
    let urlByGallery: String
    let likesCount: Int
    let userLikes: Int
}
