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
        titleLabel.sizeToFit()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleImageView.sizeToFit()
        subTitleLabel.sizeToFit()
        subTitleLabel.adjustsFontSizeToFitWidth = true
        enterButton.sizeToFit()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBAction func didPressEnterAnonymously(sender: AnyObject) {
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            // ...
        }

    }
}