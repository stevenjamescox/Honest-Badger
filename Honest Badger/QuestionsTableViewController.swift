//
//  QuestionsTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import MessageUI

class QuestionsTableViewController: UITableViewController, QuestionResponseDelegate, MFMailComposeViewControllerDelegate{

    let frontPageViewController = FrontPageViewController()
    
    var questions = [Question]()
    
    var currentIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.blackColor()

        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        QuestionController.fetchQuestions { (questions) in
            self.questions = questions.sort {$0.timeLimit.timeIntervalSince1970 > $1.timeLimit.timeIntervalSince1970}
            self.tableView.reloadData()
            
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("questionCell", forIndexPath: indexPath) as? QuestionTableViewCell ?? QuestionTableViewCell()

        let question = questions[indexPath.row]
       
        cell.delegate = self
        cell.loadQuestionInfo(question)
        
        return cell
    }

    // MARK: - Navigation
     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toViewResponsesSegue" {
            let responsesTableViewController = segue.destinationViewController as? ResponsesTableViewController
            if let indexPath = currentIndexPath {
                let question = questions[indexPath.row]
                responsesTableViewController?.question = question
            }
        }
        
        if segue.identifier == "toSubmitResponseSegue" {
            let submitResponseTableViewController = segue.destinationViewController as? SubmitResponseTableViewController
            if let indexPath = currentIndexPath {
                let question = questions[indexPath.row]
                submitResponseTableViewController?.question = question
            }
        }
    }
  
    func submitResponseToQuestionButtonTapped(sender: QuestionTableViewCell) {
        if let indexPath = tableView.indexPathForCell(sender) {
            currentIndexPath = indexPath
            let question = questions[indexPath.row]
            
            if question.timeLimit.timeIntervalSince1970 > NSDate().timeIntervalSince1970{
                self.performSegueWithIdentifier("toSubmitResponseSegue", sender: self)
            } else { return }
        }
    }
    
    func viewResponseButtonTapped(sender: QuestionTableViewCell) {
        if let indexPath = tableView.indexPathForCell(sender) {
        currentIndexPath = indexPath
            let question = questions[indexPath.row]
            
            if question.timeLimit.timeIntervalSince1970 < NSDate().timeIntervalSince1970{
                
                self.performSegueWithIdentifier("toViewResponsesSegue", sender: self)
            } else { return }
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
    
    func reportQuestionButtonTapped(sender: QuestionTableViewCell){
        if let indexPath = tableView.indexPathForCell(sender) {
            currentIndexPath = indexPath
            let question = questions[indexPath.row]
            
             if MFMailComposeViewController.canSendMail() {
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                
                composeVC.setToRecipients(["address@example.com"])
                composeVC.setSubject("Hello!")
                composeVC.setMessageBody("Hello from California!", isHTML: false)
                
                self.presentViewController(composeVC, animated: true, completion: nil)
            } else {
                 self.showSendMailErrorAlert()
            }
        }
    }
    
}