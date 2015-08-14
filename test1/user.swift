
//
//  User.swift
//  test1
//
//  Created by Kenneth Lee on 6/30/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import Foundation

let kBaseURL:String = "http://localhost:3000/"
let kUser:String = "users"

class User {

    var id: String = "0"
    var username: String
    var password: String
    var isEmployee: String
    
    init(username: String,password: String,isEmployee: String) {
        self.username = username
        self.password = password
        self.isEmployee = isEmployee
    }
    
    init(id: String,username: String,password: String,isEmployee: String) {
        self.id = id
        self.username = username
        self.password = password
        self.isEmployee = isEmployee
    }
    
    init(dict:NSDictionary) {
        self.id = (dict["_id"] as? String)!
        self.username = (dict["username"] as? String)!
        self.password = (dict["password"] as? String)!
        self.isEmployee = (dict["isEmployee"] as? String)!
    }
    
    func safeSet(d: NSMutableDictionary, k: String, v: String) {
            d[k] = v
    }
    
    func toDictionary() -> NSDictionary {
        let jsonable = NSMutableDictionary();
        self.safeSet(jsonable, k: "id", v: self.id);
        self.safeSet(jsonable, k: "username", v: self.username);
        self.safeSet(jsonable, k: "password", v: self.password);
        self.safeSet(jsonable, k: "isEmployee", v: self.isEmployee);
        return jsonable
        
    }
}





