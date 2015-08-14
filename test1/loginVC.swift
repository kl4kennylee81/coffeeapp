//
//  loginVC.swift
//  test1
//
//  Created by Kenneth Lee on 6/30/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func autheticateUser(username:String,pass:String) {
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
                var users_1 = Users()
                users_1.parseAddValue(responseArray)
                users_1.autheticated = users_1.autheticate(username,password:pass)
                if (users_1.autheticated) {
                    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    if (users_1.isEmployee) {
                        NSLog("is true")
                    }
                    prefs.setObject(username, forKey: "USERNAME")
                    prefs.setObject(users_1.isEmployee, forKey: "EMPLOYEE")
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else {
                    //add alert here
                }
            }
            else {
                NSLog((error!.localizedDescription) as String)
            }
        })
        task.resume()
    }
    
    
    @IBAction func signinTapped(sender: UIButton) {
        var username:String = txtUsername.text
        var password:String = txtPassword.text
        if ( username == "") || (password == "") {
            //add alert here
        }
        else {
            self.autheticateUser(username,pass:password)
        }
            
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
