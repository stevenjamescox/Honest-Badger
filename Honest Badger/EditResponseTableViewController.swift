//
//  EditResponseTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 9/16/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import MessageUI

class EditResponseTableViewController: UITableViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {
        
        var question: Question?
        var currentIndexPath: IndexPath?
        var timer: Timer?
        var formatter = DateComponentsFormatter()
        var cellHeight: CGFloat?
    
        var responseTextToPresent: String = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
            navBar.tintColor = UIColor.black
            
            responseEntryField.becomeFirstResponder()
            responseEntryField.delegate = self
            
            questionPresent.text = "\(question!.questionText)"
            
            ResponseController.getSingleResponse(question!) { (responseText) in
                if responseText != nil {
                    self.responseTextToPresent = responseText!
                    self.responseEntryField.text = self.responseTextToPresent
                }
            }
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
            
            questionPresent.font = UIFont.init(name: "Rockwell", size: 21.0)
            countdownClock.font = UIFont.init(name: "Rockwell", size: 26.0)
            
            timeLeftOutlet.font = UIFont.init(name: "Rockwell", size: 25.0)
            reviseResponseButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 21.0)
        }
        
        // MARK: - Outlets
        
        @IBOutlet weak var navBar: UINavigationBar!
        @IBOutlet weak var questionPresent: UILabel!
        @IBOutlet weak var responseEntryField: UITextView!
        @IBOutlet weak var countdownClock: UILabel!
    
        @IBOutlet weak var reviseResponseButtonOutlet: UIButton!
    
        @IBOutlet weak var timeLeftOutlet: UILabel!
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let newLength = textView.text!.characters.count + text.characters.count - range.length
            if textView == responseEntryField {
                return newLength <= 200
            }
            return true
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 11
        }
        
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            switch (indexPath as NSIndexPath).row {
            case 0:
                return 65
            case 1:
                return 30
            case 2:
                return cellHeight! - 60
            case 3:
                return 30
            case 4:
                return 120
            case 5:
                return 50
            case 6:
                return 4
            case 7:
                return 70
            case 8:
                return 4
            case 9:
                return 90
            case 10:
                return 300
            default:
                return 50
            }
        }
        
        func showSendMailErrorAlert(){
            let sendMailErrorAlert =
                UIAlertController(title: "Couldn't Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel){ (action) in print(action)}
            sendMailErrorAlert.addAction(dismissAction)
            
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            self.dismiss(animated: true, completion: nil)
        }
        
        override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Report question as inappropriate", style: .destructive) { action in
                print("reported question at \(indexPath)")
                
                if MFMailComposeViewController.canSendMail() {
                    let composeVC = MFMailComposeViewController()
                    composeVC.mailComposeDelegate = self
                    composeVC.setToRecipients(["report@honestbadger.com"])
                    composeVC.setSubject("Inappropriate Question Report")
                    composeVC.setMessageBody("Question to report:\n'\(self.question!.questionText)'\n\n Thank you for your report! Do you have any comments to add?: \n\n\n\n\n\n\n \n*******************\nDeveloper Data:\n\(self.question!.identifier!)\nts:\(self.question!.timestamp.timeIntervalSince1970)\ntL:\(self.question!.timeLimit.timeIntervalSince1970)\n*******************", isHTML: false)
                    
                    self.present(composeVC, animated: true, completion: nil)
                } else {
                    self.showSendMailErrorAlert()
                }
                
                tableView.deselectRow(at: indexPath, animated: true)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
                tableView.deselectRow(at: indexPath, animated: true)
            })
            present(alert, animated: true, completion: nil)
        }
        
        @IBAction func cancelButtonTapped(_ sender: AnyObject) {
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func didPressSubmitResponse(_ sender: AnyObject) {
            if (responseEntryField.text != "") {
                let responseText = responseEntryField.text
                ResponseController.submitResponse(question!, responseText: responseText!)
                responseEntryField.text = ""
                self.createAlert("Thanks!", message: "Your revised response has been received! Come back when the clock runs out to view the rest of the responses.")
            } else {
                return
            }
        }
        
        @IBAction func didPressSubmitResponseAlternate(_ sender: AnyObject) {
            if (responseEntryField.text != "") {
                let responseText = responseEntryField.text
                ResponseController.submitResponse(question!, responseText: responseText!)
                responseEntryField.text = ""
                self.createAlert("Thanks!", message: "Your revised response has been received! Come back when the clock runs out to view the rest of the responses.")
            } else {
                return
            }
        }
        
        func createAlert(_ title: String, message: String = "") {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default) {
                UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okayAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        func timerFired(_ timer: Timer?){
            guard let question = self.question else
                
            { return }
            
            let dateComparisonResult: ComparisonResult = Date().compare(question.timeLimit as Date)
            if dateComparisonResult == ComparisonResult.orderedAscending {
                
                formatter.unitsStyle = .positional
                let interval: Double = question.timeLimit.timeIntervalSince1970 - Date().timeIntervalSince1970
                countdownClock.text = " \(formatter.string(from: interval)!)"
                countdownClock.textColor = UIColor.black
                
            } else{
                
                self.dismiss(animated: true, completion: nil)
            }
        }
}
