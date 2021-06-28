//
//  TabBarController.swift
//  VKClient
//
//  Created by Кирилл Копытин on 01.06.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
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
    }
}
