//
//  Users.swift
//  test1
//
//  Created by Kenneth Lee on 6/30/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import Foundation

class Users {
    
    let kBaseURL:String = "http://localhost:3000/"
    let kUser:String = "users"
    
    var user_list:NSMutableArray
    var autheticated:Bool
    var isEmployee:Bool

    func parseAddValue(response:NSArray) {
        for item in response {
            var user_1 = User(dict: item as! NSDictionary)
            self.user_list.addObject(user_1)
        }
    }
    
    init(){
        user_list = []
        autheticated = false
        isEmployee = false
    }
    
    func autheticate(username:String,password:String)->Bool {
        for item in self.user_list{
            var user_1:User = item as! User
            if ((user_1.username == username)&&(user_1.password == password)) {
                var unwrap_emp = user_1.isEmployee
                    if (unwrap_emp == "yes") {
                        isEmployee = true
                    }
                    else {
                        isEmployee = false
                    }
                return true
            }
        }
        return false
    }
    
    
    func getUsers(){
        var url:NSURL = NSURL(string:kBaseURL.stringByAppendingPathComponent(kUser))!;
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            if (error == nil){
                var new_error: NSError?
                var responseArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &new_error) as! NSArray
                self.parseAddValue(responseArray)
            }
            else {
                NSLog((error!.localizedDescription) as String)
            }
        })
        task.resume()
    }
    

}