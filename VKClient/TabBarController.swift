//
//  TabBarController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 01.06.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    func fillFriendsArray() {
        DataStorage.shared.friendsArray = [
            User(firstName: "Кирилл", secondName: "Копытин", photos: [UIImage(named: "photo1")!, UIImage(named: "photo2")!], avatar: UIImage(named: "user1")),
            User(firstName: "Анна", secondName: "Плетнева", photos: nil, avatar: UIImage(named: "user2")),
            User(firstName: "Алла", secondName: "Пугачева", photos: [UIImage(named: "photo3")!, UIImage(named: "photo4")!], avatar: UIImage(named: "user3")),
            User(firstName: "Филипп", secondName: "Киркоров", photos: nil, avatar: UIImage(named: "user4")),
            User(firstName: "Наталья", secondName: "Иванова", photos: nil, avatar: nil),
            User(firstName: "Павел", secondName: "Дуров", photos: [UIImage(named: "photo1")!, UIImage(named: "photo2")!, UIImage(named: "photo3")!, UIImage(named: "photo4")!, UIImage(named: "photo5")!], avatar: UIImage(named: "user5")),
            User(firstName: "Уилл", secondName: "Смит", photos: nil, avatar: UIImage(named: "user6")),
            User(firstName: "Михаил", secondName: "Задорнов", photos: nil, avatar: UIImage(named: "user7")),
            User(firstName: "Олег", secondName: "Пронин", photos: [UIImage(named: "photo6")!, UIImage(named: "photo7")!], avatar: nil),
            User(firstName: "Ирина", secondName: "Казакова", photos: nil, avatar: UIImage(named: "user8")),
            User(firstName: "Анджелина", secondName: "Джоли", photos: [UIImage(named: "photo8")!, UIImage(named: "photo9")!, UIImage(named: "photo10")!], avatar: UIImage(named: "user9")),
            User(firstName: "Иван", secondName: "Горлов", photos: [UIImage(named: "photo7")!], avatar: UIImage(named: "user10"))
        ]
    }
    
    func fillAllGroupsArray() {
        DataStorage.shared.allGroupsArray = [
            Group(name: "Комиксы BUBBLE", avatar: UIImage(named: "bubble")),
            Group(name: "Любители собак", avatar: nil),
            Group(name: "Азбука - графические романы", avatar: UIImage(named: "azbuka")),
            Group(name: "Издательство Сокол", avatar: UIImage(named: "sokol")),
            Group(name: "Бегуны", avatar: nil),
            Group(name: "Магазин комиксов Сomic Street", avatar: UIImage(named: "comic_street")),
            Group(name: "Eaglemoss", avatar: UIImage(named: "eaglemoss")),
            Group(name: "Любители кошек", avatar: UIImage(named: "cats"))
        ]
    }
    
    func fillNewsArray() {
        DataStorage.shared.newsArray = [
            News(description: "TEst test test", photo: UIImage(named: "photo4")),
            News(description: nil, photo: UIImage(named: "photo5")),
            News(description: "TEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test testTEst test test", photo: UIImage(named: "photo3")),
            News(description: "TEst test test", photo: nil),
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillNewsArray()
        fillFriendsArray()
        fillAllGroupsArray()
    }
}
