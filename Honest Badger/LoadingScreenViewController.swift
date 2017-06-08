//
//  LoadingScreenViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 10/20/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import Firebase

class LoadingScreenViewController: UIViewController {
    
    var isUserLoggedInOnServer: Bool?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        FirebaseApp.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserController.isLoggedInServerTest { (success, error) in
            if success == true {
                self.isUserLoggedInOnServer = true
                UserController.restoreUserIdToDevice()
                self.performSegue(withIdentifier: "loadingScreenToGlobalSegue", sender: nil)
                self.activityIndicator.removeFromSuperview()
            } else {
                self.isUserLoggedInOnServer = false
                if UserController.shared.currentUser == nil || self.isUserLoggedInOnServer == false {
                    self.performSegue(withIdentifier: "loadingScreenToSignUpSignInSegue", sender: nil)
                    self.activityIndicator.removeFromSuperview()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
