//
//  signupVC.swift
//  test1
//
//  Created by Kenneth Lee on 6/30/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import UIKit

class employee_wVC: UIViewController {
    @IBOutlet var txtLabel: UILabel!
    
    var timer:NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2.0),
            target:self,
            selector: Selector("check_transaction"),
            userInfo: nil,
            repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func check_transaction(){
        var url:NSURL = NSURL(string:kBaseURL.stringByAppendingPathComponent(kTransactions))!;
        NSLog(kBaseURL.stringByAppendingPathComponent(kTransactions))
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        var reponseError: NSError?
        var response: NSURLResponse?
        var urldata = NSURLConnection.sendSynchronousRequest(request,returningResponse:&response, error:&reponseError)
            if (urldata != nil){
                var new_error: NSError?
                var responseArray = NSJSONSerialization.JSONObjectWithData(urldata!, options: NSJSONReadingOptions(0), error: &reponseError) as! NSArray
                var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                var tempString:String = (prefs.valueForKey("USERNAME") as? String)!
                var trans:NSDictionary = accept_trans(responseArray,tempString)
                if (trans.count > 0) {
                    self.timer.invalidate()
                    self.txtLabel.text = (trans["acceptor_id"] as! String)+" will be attending your Needs"
                    self.txtLabel.sizeToFit()
                    NSLog(trans["_id"] as! String)
                    //call the delete transaction function or update the db to include processed
                    var delete_id:String = trans["_id"] as! String
                    deleteTransaction(delete_id)
                }
                
            }
            else {
            }
    }
    
    func cancelTransaction() {
        var url:NSURL = NSURL(string:kBaseURL.stringByAppendingPathComponent(kTransactions))!;
        NSLog(kBaseURL.stringByAppendingPathComponent(kTransactions))
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        var reponseError: NSError?
        var response: NSURLResponse?
        var urldata = NSURLConnection.sendSynchronousRequest(request,returningResponse:&response, error:&reponseError)
        if (urldata != nil){
            var new_error: NSError?
            var responseArray = NSJSONSerialization.JSONObjectWithData(urldata!, options: NSJSONReadingOptions(0), error: &reponseError) as! NSArray
            var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            var tempString:String = (prefs.valueForKey("USERNAME") as? String)!
            var trans_ids:Array<String> = return_user_trans(responseArray, tempString)
            for ids in trans_ids {
                deleteTransaction(ids)
            }
            self.performSegueWithIdentifier("backtoWelcome", sender: self)
        }
    }

    @IBAction func returnWelcome(sender: AnyObject) {
        cancelTransaction()
        timer.invalidate()
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
