//
//  BaseModel.swift
//  VKClient
//
//  Created by Кирилл Копытин on 30.06.2021.
//

import RealmSwift
import DynamicJSON

public class BaseObject: Object {

    convenience required init(data: JSON) {
        self.init()
    }
}
