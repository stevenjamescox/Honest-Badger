//
//  ResponsesTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import MessageUI

class ResponsesTableViewController: UITableViewController, ResponseReportDelegate, MFMailComposeViewControllerDelegate {
    
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
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return question?.responses.count ?? 0
       
    }
    
    /*
     let cell = tableView.dequeueReusableCellWithIdentifier("questionCell", forIndexPath: indexPath) as? QuestionTableViewCell ?? QuestionTableViewCell()
     
     let question = questions[indexPath.row]
 
 */
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("responseCell", forIndexPath: indexPath) as? ResponsesTableViewCell ?? ResponsesTableViewCell()

        
        if question?.responses.count > 0 {
            if let response = question?.responses[indexPath.row]{
                cell.delegate = self
                cell.loadResponseInfo(response)
            }
        } else {
            cell.textLabel?.text = "no responses"
        }
        // ***************
        //RUNS RANDOMIZE FUNCTION FROM RESPONSE CONTROLLER, PRESENTS RESPONSES FOR RESPECTIVE QUESTION
        // *********
        
        return cell
    }
    /*
     
     
     let question = questions[indexPath.row]
     
     cell.delegate = self
     cell.loadQuestionInfo(question)
     
     return cell
     
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // ***************
     RUNS RANDOMIZE FUNCTION FROM RESPONSE CONTROLLER, PRESENTS RESPONSES FOR RESPECTIVE QUESTION
     // *********
     
     return cell
     }
     */
    
    func reportResponseButtonTapped(sender: ResponsesTableViewCell){
}
    
   
    
}
