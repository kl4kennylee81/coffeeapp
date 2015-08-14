//
//  ViewController.swift
//  test1
//
//  Created by Kenneth Lee on 6/30/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            var isemployee:Bool = false
            if (prefs.valueForKey("EMPLOYEE") != nil) {
                isemployee = prefs.valueForKey("EMPLOYEE") as! Bool
                if !(isemployee) {
                    self.performSegueWithIdentifier("goto_intern", sender: self)
                }
            }
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as? String
        }
    }
    
    @IBAction func requestOrder(sender: UIButton) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var transact:NSDictionary = NSMutableDictionary();
        var tempString:String = (prefs.valueForKey("USERNAME") as? String)!
        transact = ["sender_id":tempString]
        var url:NSURL = NSURL(string:kBaseURL.stringByAppendingPathComponent(kTransactions))!;
        var request = NSMutableURLRequest(URL: url)
        var new_error: NSError?
        var data_1:NSData = NSJSONSerialization.dataWithJSONObject(transact,options: NSJSONWritingOptions(0), error: &new_error)!
        request.HTTPMethod = "POST"
        request.HTTPBody = data_1
        request.addValue("application/json", forHTTPHeaderField:"Content-Type")
        var response: NSURLResponse?
        var urldata = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&new_error)
        if (urldata == nil){
        }
        else {
            self.performSegueWithIdentifier("goto_waiting", sender: self)
        }
        
    }
    
    @IBAction func logoutTapped(sender : UIButton) {
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
    
}

