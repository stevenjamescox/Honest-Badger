//
//  QuestionsTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController, QuestionResponseDelegate {
    
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
            
            let firstSort = questions.divide({ $0.timeLimit.timeIntervalSince1970 >= NSDate().timeIntervalSince1970 })
            
            let openQuestions = firstSort.slice
            let closedQuestions = firstSort.remainder

            let sortedOpenQuestions = openQuestions.sort {($0.timeLimit.timeIntervalSince1970) < ($1.timeLimit.timeIntervalSince1970)}
            let sortedClosedQuestions = closedQuestions.sort {($0.timeLimit.timeIntervalSince1970) > ($1.timeLimit.timeIntervalSince1970)}
            
            let fullySortedArray = sortedOpenQuestions + sortedClosedQuestions

            self.questions = fullySortedArray
            self.tableView.reloadData()
        
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
                if let cell = tableView.cellForRowAtIndexPath(indexPath) as? QuestionTableViewCell {
                    submitResponseTableViewController?.cellHeight = cell.frame.height
                }
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
}

extension SequenceType {
    
    /**
     Returns a tuple with 2 arrays.
     The first array (the slice) contains the elements of self that match the predicate.
     The second array (the remainder) contains the elements of self that do not match the predicate.
     */
    func divide(@noescape predicate: (Self.Generator.Element) -> Bool) -> (slice: [Self.Generator.Element], remainder: [Self.Generator.Element]) {
        var slice:     [Self.Generator.Element] = []
        var remainder: [Self.Generator.Element] = []
        forEach {
            switch predicate($0) {
            case true  : slice.append($0)
            case false : remainder.append($0)
            }
        }
        return (slice, remainder)
    }
}