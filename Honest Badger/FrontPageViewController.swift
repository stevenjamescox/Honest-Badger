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
        enterButton.enabled = true
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBAction func didPressEnterAnonymously(sender: AnyObject) {
        enterButton.enabled = false
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            
            if user != nil && error == nil {
            self.performSegueWithIdentifier("fromLoginToQuestionsTableView", sender: self)
            }
            
            if error != nil {
                    if let errCode = FIRAuthErrorCode(rawValue: error!.code) {
                        switch errCode {
                        case .ErrorCodeTooManyRequests:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Too many recent login attempts from your device. Please wait a little while and try again.")
                        case .ErrorCodeInternalError:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Internal error. Please try again.")
                        case .ErrorCodeNetworkError:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Not able to connect to the Internt. Please test your connection and try again.")
                        default:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Login failed due to an unexpected error. PLease try again.")
                        }
                    }
                }
            }
        }
    
    func createAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        alert.addAction(okayAction)
        self.presentViewController(alert, animated: true, completion: nil)
        enterButton.enabled = true
    }
}