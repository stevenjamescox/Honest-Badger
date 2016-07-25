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
        self.navigationController?.navigationBarHidden = true
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressEnterAnonymously(sender: AnyObject) {
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            // ...
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
