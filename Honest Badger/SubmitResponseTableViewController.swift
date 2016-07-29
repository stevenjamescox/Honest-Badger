//
//  SubmitResponseTableViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class SubmitResponseTableViewController: UITableViewController {

    var question: Question?
    
    var timer: NSTimer?
    var formatter = NSDateComponentsFormatter()
    var cellHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navBar.tintColor = UIColor.blackColor()
        
        responseEntryField.becomeFirstResponder()

        questionPresent.text = "\(question!.questionText)"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
    }
    
    /*
   
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
    }*/
    
    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var questionPresent: UILabel!
    @IBOutlet weak var responseEntryField: UITextView!
    @IBOutlet weak var countdownClock: UILabel!

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

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 65
        case 1:
            return 30
        case 2:
            return cellHeight! - 60 ?? 50
        case 3:
            return 30
        case 4:
            return 150
        case 5:
            return 70
        case 6:
            return 4
        case 7:
            return 70
        case 8:
            return 4
        case 9:
            return 90
        case 10:
            return 90
        default:
            return 50
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressSubmitResponse(sender: AnyObject) {
        if (responseEntryField.text != "") {
        let responseText = responseEntryField.text
        ResponseController.submitResponse(question!, responseText: responseText)
        responseEntryField.text = ""
        self.dismissViewControllerAnimated(true, completion: nil)
        } else {
        return
        }
    }

    func timerFired(timer: NSTimer?){
        
        guard let question = self.question else
        
        { return }
        
        let dateComparisonResult: NSComparisonResult = NSDate().compare(question.timeLimit)
         if dateComparisonResult == NSComparisonResult.OrderedAscending {
        
            formatter.unitsStyle = .Positional
        let interval: Double = question.timeLimit.timeIntervalSince1970 - NSDate().timeIntervalSince1970
            countdownClock.text = " \(formatter.stringFromTimeInterval(interval)!)"
            countdownClock.textColor = .blackColor()

        } else{
        
        self.dismissViewControllerAnimated(true, completion: nil)
        }
    
    }

}
