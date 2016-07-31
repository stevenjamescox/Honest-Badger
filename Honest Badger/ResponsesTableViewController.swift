//
//  ResponsesTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import MessageUI

class ResponsesTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    var question: Question?
    
    var currentIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
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

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
        
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
        
        default:
            
            tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Report response as inappropriate", style: .Destructive) { action in
                print("reported response at \(indexPath)")
                
                let responseTextForEmail = self.question?.responses[indexPath.row]
                
                if MFMailComposeViewController.canSendMail() {
                    let composeVC = MFMailComposeViewController()
                    composeVC.mailComposeDelegate = self
                    composeVC.setToRecipients(["report@honestbadger.com"])
                    composeVC.setSubject("Inappropriate Response Report")
                    composeVC.setMessageBody("Response to report:\n'\(responseTextForEmail!)'\n\n Thank you for your report! Do you have any comments to add?: \n\n\n\n\n\n\n \n*******************\nDeveloper Data:\n\(self.question!.identifier!)\nts:\(self.question!.timestamp.timeIntervalSince1970)\ntL:\(self.question!.timeLimit.timeIntervalSince1970)\n*******************", isHTML: false)
                    
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
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return (question?.responses.count)!
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
        let responseQuestionReferenceCell = tableView.dequeueReusableCellWithIdentifier("responseQuestionReference", forIndexPath: indexPath)
        guard let questionTextForCell = question?.questionText else { return responseQuestionReferenceCell }
        
        responseQuestionReferenceCell.textLabel?.text = questionTextForCell
        
        return responseQuestionReferenceCell
    
        default:
        let cell = tableView.dequeueReusableCellWithIdentifier("simpleResponse", forIndexPath: indexPath)
        guard let response = question?.responses[indexPath.row] where question?.responses.count > 0 else { return cell }
        
        cell.textLabel?.text = response
        
        return cell

        }
    }
}