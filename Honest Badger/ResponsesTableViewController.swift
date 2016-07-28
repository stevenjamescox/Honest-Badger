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
    
    // MARK: - Table view delegate
    
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "Report as inappropriate", style: .Destructive) { action in
            print("reported at \(indexPath)")
            // TODO: Send email
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { action in
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        })
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (question?.responses.count)!
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("simpleResponse", forIndexPath: indexPath)
        guard let response = question?.responses[indexPath.row] where question?.responses.count > 0 else { return cell }
        cell.textLabel?.text = response
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
