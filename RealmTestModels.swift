//
//  RealmTestModels.swift
//  Created by meguid
//

import Foundation
import RealmSwift

class RealmParentUser: Object {
    
    dynamic var first_name = ""
    dynamic var last_name = ""
    dynamic var age = 25
    dynamic var isHappy = true
}

class ChildUser: Object {
    
    var parents = List<RealmParentUser>()
    dynamic var name = ""
    dynamic var toys = 5200
    dynamic var isFine = false
}
