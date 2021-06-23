//
//  TabBarController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 01.06.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
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
        fillAllGroupsArray()
    }
}
