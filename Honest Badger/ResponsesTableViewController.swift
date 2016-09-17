//
//  ResponsesTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import MessageUI

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ResponsesTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    var question: Question?
    
    var currentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController!.navigationBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.black
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        tableView.deselectRow(at: indexPath, animated: true)
        
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

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        switch (indexPath as NSIndexPath).section {
        case 0:
        
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
        
        default:
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Report response as inappropriate", style: .destructive) { action in
                print("reported response at \(indexPath)")
                
                let responseTextForEmail = self.question?.responses[(indexPath as NSIndexPath).row]
                
                if MFMailComposeViewController.canSendMail() {
                    let composeVC = MFMailComposeViewController()
                    composeVC.mailComposeDelegate = self
                    composeVC.setToRecipients(["report@honestbadger.com"])
                    composeVC.setSubject("Inappropriate Response Report")
                    composeVC.setMessageBody("Response to report:\n'\(responseTextForEmail!)'\n\n Thank you for your report! Do you have any comments to add?: \n\n\n\n\n\n\n \n*******************\nDeveloper Data:\n\(self.question!.identifier!)\nts:\(self.question!.timestamp.timeIntervalSince1970)\ntL:\(self.question!.timeLimit.timeIntervalSince1970)\n*******************", isHTML: false)
                    
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
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return (question?.responses.count)!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath as NSIndexPath).section {
        case 0:
        let responseQuestionReferenceCell = tableView.dequeueReusableCell(withIdentifier: "responseQuestionReference", for: indexPath)
        guard let questionTextForCell = question?.questionText else { return responseQuestionReferenceCell }
        
        responseQuestionReferenceCell.textLabel?.font = UIFont.init(name: "Rockwell", size: 21.0)
        responseQuestionReferenceCell.textLabel?.text = questionTextForCell
        let customColorView = UIView()
        customColorView.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)
        responseQuestionReferenceCell.selectedBackgroundView = customColorView
        return responseQuestionReferenceCell
    
        default:
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleResponse", for: indexPath)
        //cell.textLabel?.font = UIFont.init(name: "Rockwell", size: 16.0)
        guard let response = question?.responses[(indexPath as NSIndexPath).row] , question?.responses.count > 0 else { return cell }
        
        cell.textLabel?.text = response
        
        return cell

        }
    }
}
