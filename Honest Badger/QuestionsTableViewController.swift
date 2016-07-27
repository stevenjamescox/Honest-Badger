//
//  QuestionsTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController {

    let frontPageViewController = FrontPageViewController()
    
    var questions = [Question]()
    
    override func viewDidLoad() {
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.blackColor()

        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        QuestionController.fetchQuestions { (questions) in
            self.questions = questions.sort {$0.timestamp.timeIntervalSince1970 > $1.timestamp.timeIntervalSince1970}
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
       
        cell.loadQuestionInfo(question)
        
        return cell
    }

    // MARK: - Navigation
     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toViewResponsesSegue" {
            let responsesTableViewController = segue.destinationViewController as? ResponsesTableViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                let question = questions[indexPath.row]
                responsesTableViewController?.question = question
            }
            
        }
        
        if segue.identifier == "toSubmitResponseSegue" {
            let submitResponseTableViewController = segue.destinationViewController as? SubmitResponseTableViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                let question = questions[indexPath.row]
                submitResponseTableViewController?.question = question
            }
            
        }
    }
    
    
    @IBAction func submitResponseButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("toSubmitResponseSegue", sender: self)
        
        
    }
    
    
    @IBAction func viewResponsesButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("toViewResponsesSegue", sender: self)
    }
    
    
    
    
    
    
    
}
