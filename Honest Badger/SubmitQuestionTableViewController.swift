//
//  SubmitQuestionTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class SubmitQuestionTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navBar.tintColor = UIColor.blackColor()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.dateFromString("02:00")
        timeLimitPicker.date = date!

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var questionEntryField: UITextField!

    @IBOutlet weak var timeLimitPicker: UIDatePicker!
    
    @IBAction func timeLimitPickerAction(sender: AnyObject) {
        
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //***IBAction func setTimestamp
    //***adds NOW time to TIME LEFT to create the END question timestamp
    
    //****IBAction actualSubmitQuestion(){}
    // calls submitQuestion in QuestionController
    //---uses the entered text in questionEntryField (if not nil) to fill dataPoint 2
    //---uses entered time in timeLimitPicker (does the comparison in function) to fill dataPoint 5
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    @IBAction func didPressSubmitQuestion(sender: AnyObject) {
        if (questionEntryField.text != "") {
        let questionText = questionEntryField.text
        let _ = timeLimitPicker.countDownDuration + Double((NSDate().timeIntervalSince1970)*1000)
        QuestionController.submitQuestion(questionText!)
        questionEntryField.text = ""
        self.dismissViewControllerAnimated(true, completion: nil)
        } else {
        return
        }
    
    }

}
    
    

