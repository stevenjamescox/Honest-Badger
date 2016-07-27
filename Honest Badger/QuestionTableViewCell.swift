//
//  QuestionTableViewCell.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell, UITableViewDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var reportQuestionButton: UIButton!
    
    @IBOutlet weak var submitResponseButton: UIButton!
    @IBOutlet weak var viewResponsesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
    }
    
    var question: Question?
    
    var timer: NSTimer?
    var formatter = NSDateFormatter()
    
    func timerFired(timer: NSTimer?){
        
        guard let question = self.question else
        
        { return }

        let dateComparisonResult: NSComparisonResult = NSDate().compare(question.timeLimit)
        if dateComparisonResult == NSComparisonResult.OrderedAscending
            
        {
            submitResponseButton.setTitle("Submit Response", forState: .Normal)
            submitResponseButton.backgroundColor = UIColor(red: 133/255, green: 178/255, blue: 131/255, alpha: 1)
         
            formatter.dateFormat = "H:mm:ss"
            let interval = question.timeLimit.timeIntervalSinceDate(NSDate())
            let date = NSDate(timeIntervalSince1970: interval)
            let formattedDateString = formatter.stringFromDate(date)

            viewResponsesButton.setTitle("\(formattedDateString) left\n to respond", forState: .Normal)
            viewResponsesButton.backgroundColor = .whiteColor()
            
        } else {
            
            submitResponseButton.setTitle(" \(question.responses.count) responses\n    received", forState: .Normal)
            submitResponseButton.backgroundColor = .whiteColor()
            viewResponsesButton.setTitle("View Responses", forState: .Normal)
            viewResponsesButton.backgroundColor = UIColor(red: 249/255, green: 81/255, blue: 197/255, alpha: 1)
        }
    }

    func loadQuestionInfo(question: Question) {
        self.question = question
        self.timerFired(nil)
        questionLabel.text = "  \(question.questionText)"
    }
}