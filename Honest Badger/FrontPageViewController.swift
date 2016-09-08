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
        enterButton.titleLabel?.font = UIFont.init(name: "Rockwell", size: 23.0)
        enterButton.isEnabled = true
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBAction func didPressEnterAnonymously(_ sender: AnyObject) {
        enterButton.isEnabled = false
        enterButton.setTitle("Logging In...", for: UIControlState())
        FIRAuth.auth()?.signInAnonymously() { (user, error) in
            
            if user != nil && error == nil {
            UserController.shared.currentUserID = (user?.uid)!
            self.performSegue(withIdentifier: "fromLoginToQuestionsTableView", sender: self)
            }
            
            if error != nil {
                    if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .errorCodeTooManyRequests:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Too many recent login attempts from your device. Please wait a little while and try again.")
                        case .errorCodeInternalError:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Internal error. Please try again.")
                        case .errorCodeNetworkError:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Not able to connect to the Internet. Please test your connection and try again.")
                        default:
                            self.createAlert("Error: \(errCode.rawValue)", message: "Login failed due to an unexpected error. Please try again.")
                        }
                    }
                }
            }
        }
    
    func createAlert(_ title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
        enterButton.isEnabled = true
        enterButton.setTitle("Enter Anonymously", for: UIControlState())
    }
}
