//
//  Category.swift
//  Todoey
//
//  Created by Dowon Kim on 01/09/2023.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
