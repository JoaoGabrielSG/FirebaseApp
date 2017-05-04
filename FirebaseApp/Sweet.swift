//
//  Sweet.swift
//  FirebaseApp
//
//  Created by joão gabriel on 02/05/17.
//  Copyright © 2017 bepid. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Sweet {
    
    let key:String!
    let content:String!
    let addedByUser:String!
    let itemRef: FIRDatabaseReference?
    
    init(content:String, addedByUser: String, key: String="") {
        self.key = key
        self.content = content
        self.addedByUser = addedByUser
        self.itemRef = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let sweetContent = snapshot.value(forKey: "content") as? String{
            content = sweetContent
        }else{
            content = ""
        }
        
        if let sweetUser = snapshot.value(forKey: "addedByUser") as? String{
            addedByUser = sweetUser
        }else{
            addedByUser = ""
        }
    
    }
    
    func toAnyObject() -> [String:AnyObject] {
        return ["content":content as AnyObject, "addedByUser":addedByUser as AnyObject]
    }
}
