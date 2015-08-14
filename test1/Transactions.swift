//
//  Transactions.swift
//  test1
//
//  Created by Kenneth Lee on 7/1/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import Foundation

let kTransactions:String = "transactions"

class Transactions {
    let kBaseURL:String = "http://localhost:3000/"
    
    var sender_id:String
    var acceptor_id:String?
    
    func safeSet(d: NSMutableDictionary, k: String, v: String) {
        d[k] = v
    }
    
    init(send_id:String,accept_id:String){
        self.sender_id = send_id
        self.acceptor_id = accept_id
    }
    
    init(dict:NSDictionary) {
        self.sender_id = dict["sender_id"] as! String
        if ((self.acceptor_id) != nil) {
            self.acceptor_id = dict["acceptor_id"]as? String
        }
    }
    
    func toDictionary(send_id:String)-> NSDictionary{
        let jsonable = NSMutableDictionary();
        self.safeSet(jsonable, k: "sender_id", v: self.sender_id);
        return jsonable
    }
    
    func toDictionary(send_id:String,accept_id:String)-> NSDictionary{
        let jsonable = NSMutableDictionary();
        self.safeSet(jsonable, k: "sender_id", v: self.sender_id);
        if ((self.acceptor_id) != nil) {
            self.safeSet(jsonable, k: "acceptor_id", v: self.acceptor_id!);
        }
        return jsonable
    }
}

func accept_trans(response:NSArray,input_user:String)->NSDictionary{
    for item in response {
        var trans = Transactions(dict:item as! NSDictionary)
        if (input_user.isEqual(trans.sender_id)) {
            if let accept = item["acceptor_id"] {
                if let unwrapp_accept = accept as? String {
                    NSLog("ACCEPTOR"+unwrapp_accept)
                    return item as! NSDictionary
                }
            }
        }
    }
    return Dictionary<String,String>()
}

func return_user_trans(response:NSArray,input_user:String)->Array<String>{
    var trans_idlist:Array<String> = []
    for item in response {
        var trans = Transactions(dict:item as! NSDictionary)
        if (input_user.isEqual(trans.sender_id)) {
            if let id = item["_id"] {
                if let unwrap_accept = id as? String {
                    trans_idlist.append(unwrap_accept);
                }
            }
        }
    }
    return trans_idlist


}

func deleteTransaction(trans_id:String){
    var urlstring = kBaseURL.stringByAppendingPathComponent(kTransactions)
    var url:NSURL = NSURL(string:urlstring.stringByAppendingPathComponent(trans_id))!;
    NSLog(urlstring.stringByAppendingPathComponent(trans_id))
    var request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField:"Accept")
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
        if (error == nil){
            NSLog("finished deleting")
        }
        else {
             NSLog("not yet deleted")
        }
    })
    task.resume()
}
