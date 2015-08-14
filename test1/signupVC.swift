//
//  signupVC.swift
//  test1
//
//  Created by Kenneth Lee on 6/30/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import UIKit

class signupVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtEmployee: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signup(){
        var username:String = txtUsername.text
        var password:String = txtPassword.text
        var employee:String = txtEmployee.text
        var confirm:String = txtConfirmPassword.text
        if !(password.isEqual(confirm)) {
            var url:NSURL = NSURL(string:kBaseURL.stringByAppendingPathComponent(kUser))!;
            var request = NSMutableURLRequest(URL: url)
            var new_error: NSError?
            var user_1:User = User(username: username, password: password, isEmployee: employee)
            var data_1:NSData = NSJSONSerialization.dataWithJSONObject(user_1.toDictionary(),options: NSJSONWritingOptions(0), error: &new_error)!
            request.HTTPMethod = "POST"
            request.HTTPBody = data_1
            request.addValue("application/json", forHTTPHeaderField:"Content-Type")
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
                if (error != nil){
                    NSLog((error!.localizedDescription) as String)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else {
                }
            })
            task.resume()
        }
        else {
        }
    }
        
    
    @IBAction func signupTapped(sender: UIButton) {
        var username:String = txtUsername.text
        var password:String = txtPassword.text
        var employee:String = txtEmployee.text
        var confirm:String = txtConfirmPassword.text
        if ( username == "") || (password == "") || (employee == "") || (confirm == "") {
            //add alert here
        }
        else {
            self.signup()
        }
        
    }


    @IBAction func gotoLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
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
