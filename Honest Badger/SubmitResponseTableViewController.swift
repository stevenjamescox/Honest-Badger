//
//  SubmitResponseTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import MessageUI

class SubmitResponseTableViewController: UITableViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {

    var question: Question?
    var currentIndexPath: NSIndexPath?
    var timer: NSTimer?
    var formatter = NSDateComponentsFormatter()
    var cellHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navBar.tintColor = UIColor.blackColor()
        
        responseEntryField.becomeFirstResponder()
        responseEntryField.delegate = self
        
        questionPresent.text = "\(question!.questionText)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var questionPresent: UILabel!
    @IBOutlet weak var responseEntryField: UITextView!
    @IBOutlet weak var countdownClock: UILabel!
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text!.characters.count + text.characters.count - range.length
        if textView == responseEntryField {
            return newLength <= 200
        }
        return true
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 65
        case 1:
            return 30
        case 2:
            return cellHeight! - 60 ?? 50
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
            return 90
        default:
            return 50
        }
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert =
            UIAlertController(title: "Couldn't Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel){ (action) in print(action)}
        sendMailErrorAlert.addAction(dismissAction)
        
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
            tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Report question as inappropriate", style: .Destructive) { action in
                print("reported question at \(indexPath)")
                
                    if MFMailComposeViewController.canSendMail() {
                        let composeVC = MFMailComposeViewController()
                        composeVC.mailComposeDelegate = self
                        composeVC.setToRecipients(["report@honestbadger.com"])
                        composeVC.setSubject("Inappropriate Question Report")
                        composeVC.setMessageBody("Question to report:\n'\(self.question!.questionText)'\n\n Thank you for your report! Do you have any comments to add?: \n\n\n\n\n\n\n \n*******************\nDeveloper Data:\n\(self.question!.identifier!)\nts:\(self.question!.timestamp.timeIntervalSince1970)\ntL:\(self.question!.timeLimit.timeIntervalSince1970)\n*******************", isHTML: false)
                        
                        self.presentViewController(composeVC, animated: true, completion: nil)
                    } else {
                        self.showSendMailErrorAlert()
                    }
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                })
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { action in
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                })
            presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressSubmitResponse(sender: AnyObject) {
        if (responseEntryField.text != "") {
        let responseText = responseEntryField.text
        ResponseController.submitResponse(question!, responseText: responseText)
        responseEntryField.text = ""
        self.dismissViewControllerAnimated(true, completion: nil)
        } else {
        return
        }
    }
    
    @IBAction func didPressSubmitResponseAlternate(sender: AnyObject) {
        if (responseEntryField.text != "") {
            let responseText = responseEntryField.text
            ResponseController.submitResponse(question!, responseText: responseText)
            responseEntryField.text = ""
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            return
        }
    }

    func timerFired(timer: NSTimer?){
        guard let question = self.question else
        
        { return }
        
        let dateComparisonResult: NSComparisonResult = NSDate().compare(question.timeLimit)
         if dateComparisonResult == NSComparisonResult.OrderedAscending {
        
            formatter.unitsStyle = .Positional
        let interval: Double = question.timeLimit.timeIntervalSince1970 - NSDate().timeIntervalSince1970
            countdownClock.text = " \(formatter.stringFromTimeInterval(interval)!)"
            countdownClock.textColor = .blackColor()

        } else{
        
        self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}