//
//  SettingsViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 9/21/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet private weak var logOutButtonOutlet: UIButton!
    
    @IBOutlet private weak var legalAndPrivacyButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController!.navigationBar.barTintColor = UIColor.badgerBlue()
        navigationController!.navigationBar.tintColor = UIColor.black
        
        self.navigationController?.isNavigationBarHidden = false
        logOutButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 21.0)
        legalAndPrivacyButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 21.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButtonTapped(_ sender: AnyObject) {
        UserController.logOutUser()
    self.performSegue(withIdentifier: "logOutSegue", sender: self)
    }
}
