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
        navBar.tintColor = UIColor.black
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        questionEntryField.becomeFirstResponder()
        questionEntryField.delegate = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: "02:00")
        timeLimitPicker.date = date!
        submitQuestionButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 23.0)
    }

    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var questionEntryField: UITextView!
    @IBOutlet weak var timeLimitPicker: UIDatePicker!
    
    @IBOutlet weak var submitQuestionButtonOutlet: UIButton!
    
    
    @IBAction func timeLimitPickerAction(_ sender: AnyObject) {

    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text!.characters.count + text.characters.count - range.length
        if textView == questionEntryField {
            return newLength <= 200
        }
        return true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }

    @IBAction func didPressSubmitQuestion(_ sender: AnyObject) {
        if (questionEntryField.text != "") {
            let questionText = questionEntryField.text
        
            let timeLimitDouble = timeLimitPicker.countDownDuration
            let timeLimit = Date(timeIntervalSince1970: (timeLimitDouble + Date().timeIntervalSince1970))
            
            QuestionController.submitQuestion(questionText!, timeLimit: timeLimit)
            questionEntryField.text = ""
            self.createAlert("Thanks!", message: "Thanks for your question! Come back when the clock runs out to view responses.")
        } else {
            return
        }
    }
    
    @IBAction func didPressSubmitQuestionAlt(_ sender: AnyObject) {
        if (questionEntryField.text != "") {
            let questionText = questionEntryField.text
            
            let timeLimitDouble = timeLimitPicker.countDownDuration
            let timeLimit = Date(timeIntervalSince1970: (timeLimitDouble + Date().timeIntervalSince1970))
            
            QuestionController.submitQuestion(questionText!, timeLimit: timeLimit)
            questionEntryField.text = ""
            self.createAlert("Thanks!", message: "Thanks for your question! Come back when the clock runs out to view responses.")
        } else {
            return
        }
    }
    
    func createAlert(_ title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
            }
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
}
