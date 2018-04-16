//
//  DBManager.swift
//  TouchNote
//
//  Created by SeonIl Kim on 2017. 12. 30..
//  Copyright © 2017년 SeonIl Kim. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    static let shared = DBManager()
    
    private init() { }
    
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            log.error("Could not access Realm")
            return nil
        }
    }

    func addMemo(content: String, title: String, priority: Int, completion: ((Bool) -> Swift.Void)? = nil) {
        DispatchQueue.global(qos: .default).async {
            let obj = MemoObj()
            obj.content = content
            obj.title = title
            obj.priority = priority
            try! self.realm?.write {
                self.realm?.add(obj)
            }
            log.info("success. \(obj)")
            DispatchQueue.main.async {
                completion!(true)
            }
        }
    }
    
    func addMemo(content: String, title: String, completion: ((Bool) -> Swift.Void)? = nil) {
        addMemo(content: content, title: title, priority: 0, completion: completion)
    }
    
    func addMemo(content: String, completion: ((Bool) -> Swift.Void)? = nil) {
        addMemo(content: content, title: "", priority: 0, completion: completion)
    }
    
    func getAllMemos() -> [MemoObj]? {
        
        if let result = realm?.objects(MemoObj.self) {
            log.info("return result success.")
            return Array(result)
        } else {
            log.error("return result nil.")
            return nil
        }
    }
    
}
