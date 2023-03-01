//
//  Category.swift
//  Cheked
//
//  Created by Furkan Gençoğulları on 14.02.2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var title: String = ""
    let items = List<Item>()
}
