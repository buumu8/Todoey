//
//  Category.swift
//  Todoey
//
//  Created by Jettapol Tuetrakul on 22/9/2561 BE.
//  Copyright © 2561 Jettapol Tuetrakul. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()    //Referencing foreign key to Item Class <Forward Relationship>
}
