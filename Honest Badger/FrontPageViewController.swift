//
//  FrontPageViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/25/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import Firebase

class FrontPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressEnterAnonymously(sender: AnyObject) {
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            // ...
        }

    }
}