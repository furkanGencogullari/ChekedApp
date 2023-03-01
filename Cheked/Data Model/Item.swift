//
//  Item.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 14.02.2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var cheked: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
