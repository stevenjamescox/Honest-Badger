//
//  QuestionsTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class AnsweredQuestionsTableViewController: UITableViewController, QuestionResponseDelegate {
    
    var userAnsweredQuestionsKeys: [String] = []
    var questions = [Question]()
    var currentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController!.navigationBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.black

        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
    
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
        
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        QuestionController.fetchAnsweredQuestionsForUserID(uid: UserController.shared.currentUserID) { (questions) in
            if let questions = questions {
                let firstSort = questions.divide({ $0.timeLimit.timeIntervalSince1970 >= Date().timeIntervalSince1970 })
                
                let openQuestions = firstSort.slice
                let closedQuestions = firstSort.remainder
                
                let sortedOpenQuestions = openQuestions.sorted {($0.timeLimit.timeIntervalSince1970) < ($1.timeLimit.timeIntervalSince1970)}
                let sortedClosedQuestions = closedQuestions.sorted {($0.timeLimit.timeIntervalSince1970) > ($1.timeLimit.timeIntervalSince1970)}
                
                let fullySortedArray = sortedOpenQuestions + sortedClosedQuestions
                
                self.questions = fullySortedArray
                self.tableView.reloadData()
            } else {
                print("questions are NIL")
                self.questions = []
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionTableViewCell ?? QuestionTableViewCell()

        let question = questions[(indexPath as NSIndexPath).row]
       
        cell.delegate = self
        cell.loadQuestionInfo(question)
        
        return cell
    }

    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toViewResponsesSegue" {
            let responsesTableViewController = segue.destination as? ResponsesTableViewController
            if let indexPath = currentIndexPath {
                let question = questions[(indexPath as NSIndexPath).row]
                responsesTableViewController?.question = question
            }
        }
        
        if segue.identifier == "toSubmitResponseSegue" {
            let submitResponseTableViewController = segue.destination as? SubmitResponseTableViewController
            if let indexPath = currentIndexPath {
                let question = questions[(indexPath as NSIndexPath).row]
                if let cell = tableView.cellForRow(at: indexPath) as? QuestionTableViewCell {
                    submitResponseTableViewController?.cellHeight = cell.frame.height
                }
                submitResponseTableViewController?.question = question
            }
        }
        
        if segue.identifier == "toEditResponseSegue" {
            let editResponseTableViewController = segue.destination as? EditResponseTableViewController
            if let indexPath = currentIndexPath {
                let question = questions[(indexPath as NSIndexPath).row]
                if let cell = tableView.cellForRow(at: indexPath) as? QuestionTableViewCell {
                    editResponseTableViewController?.cellHeight = cell.frame.height
                }
                editResponseTableViewController?.question = question
            }
        }
    }
  
    func submitResponseToQuestionButtonTapped(_ sender: QuestionTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            currentIndexPath = indexPath
            let question = questions[(indexPath as NSIndexPath).row]
            
            if question.timeLimit.timeIntervalSince1970 > Date().timeIntervalSince1970{
                
                if question.responseKeys.contains(UserController.shared.currentUserID) {
                
                self.performSegue(withIdentifier: "toEditResponseSegue", sender: self)
                
                } else {
                    
                self.performSegue(withIdentifier: "toSubmitResponseSegue", sender: self)
                    
                }
            } else { return }
        }
    }
    
    func viewResponseButtonTapped(_ sender: QuestionTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
        currentIndexPath = indexPath
            let question = questions[(indexPath as NSIndexPath).row]
            
            if question.timeLimit.timeIntervalSince1970 < Date().timeIntervalSince1970{
                
                self.performSegue(withIdentifier: "toViewResponsesSegue", sender: self)
            } else { return }
        }
    }
}
