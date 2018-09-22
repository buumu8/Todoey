//
//  Item.swift
//  Todoey
//
//  Created by Jettapol Tuetrakul on 22/9/2561 BE.
//  Copyright © 2561 Jettapol Tuetrakul. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") //Backward Relationship
}
