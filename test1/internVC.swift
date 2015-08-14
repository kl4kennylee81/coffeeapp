//
//  internVC.swift
//  test1
//
//  Created by Kenneth Lee on 7/1/15.
//  Copyright (c) 2015 Kenneth Lee. All rights reserved.
//

import UIKit

class InternVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutTapped(sender: AnyObject) {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("intern_backtoLogin", sender: self)
    }
}