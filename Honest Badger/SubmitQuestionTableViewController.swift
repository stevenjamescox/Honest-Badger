//
//  SubmitQuestionTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class SubmitQuestionTableViewController: UITableViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navBar.tintColor = UIColor.blackColor()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        questionEntryField.becomeFirstResponder()
        questionEntryField.delegate = self
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.dateFromString("02:00")
        timeLimitPicker.date = date!
    }

    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var questionEntryField: UITextView!
    @IBOutlet weak var timeLimitPicker: UIDatePicker!
    
    @IBAction func timeLimitPickerAction(sender: AnyObject) {

    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text!.characters.count + text.characters.count - range.length
        if textView == questionEntryField {
            return newLength <= 200
        }
        return true
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

    @IBAction func didPressSubmitQuestion(sender: AnyObject) {
        if (questionEntryField.text != "") {
        let questionText = questionEntryField.text
        
        let timeLimitDouble = timeLimitPicker.countDownDuration
        let timeLimit = NSDate(timeIntervalSince1970: (timeLimitDouble + NSDate().timeIntervalSince1970))
            
        QuestionController.submitQuestion(questionText!, timeLimit: timeLimit)
        questionEntryField.text = ""
        self.dismissViewControllerAnimated(true, completion: nil)
        } else {
        return
        }
    }
    
    @IBAction func didPressSubmitQuestionAlt(sender: AnyObject) {
        if (questionEntryField.text != "") {
            let questionText = questionEntryField.text
            
            let timeLimitDouble = timeLimitPicker.countDownDuration
            let timeLimit = NSDate(timeIntervalSince1970: (timeLimitDouble + NSDate().timeIntervalSince1970))
            
            QuestionController.submitQuestion(questionText!, timeLimit: timeLimit)
            questionEntryField.text = ""
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            return
        }
    }
}