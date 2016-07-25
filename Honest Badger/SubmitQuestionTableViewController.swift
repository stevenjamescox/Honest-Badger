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
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension

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
    
    @IBOutlet weak var questionEntryField: UITextField!

    
    
    @IBOutlet weak var timeLimitPicker: UIDatePicker!
    // CONFIGURES APPEARANCE OF TIME LIMIT PICKER
    // SETS DEFAULT TIME LIMIT for first appearance
    
    //***IBAction func setTimestamp
    //***adds NOW time to TIME LEFT to create the END question timestamp
    
    //****IBAction actualSubmitQuestion(){}
    // calls submitQuestion in QuestionController
    //---uses the entered text in questionEntryField (if not nil) to fill dataPoint 2
    //---uses entered time in timeLimitPicker (does the comparison in function) to fill dataPoint 5
    
    // MARK: - Table view data source
    
// THEY'RE STATIC CELLS, SO CAN REMOVE THE NEXT TWO FUNCTIONS? or how should they be filled in?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    @IBAction func didPressSubmitQuestion(sender: AnyObject) {
        let questionText = questionEntryField.text ?? ""
        let timeLimit = timeLimitPicker.countDownDuration
        QuestionController.submitQuestion(questionText)
    }
    
    
}
