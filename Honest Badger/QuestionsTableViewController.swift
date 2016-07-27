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
            self.questions = questions.sort {$0.timeLimit.timeIntervalSince1970 < $1.timeLimit.timeIntervalSince1970}
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
 
    }*/
     
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
     
     
    

}
