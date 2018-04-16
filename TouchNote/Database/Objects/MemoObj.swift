//
//  MemoObj.swift
//  TouchNote
//
//  Created by SeonIl Kim on 2017. 12. 30..
//  Copyright © 2017년 SeonIl Kim. All rights reserved.
//

import Foundation
import RealmSwift

class MemoObj:Object {
    @objc dynamic var id:String = UUID().uuidString
    
    @objc dynamic var date:Date = Date()
    @objc dynamic var priority:Int = 0
    @objc dynamic var content:String = ""
    @objc dynamic var title:String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
