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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var timer: NSTimer?
    
    var questionPerm: Question?
    
    var formatter = NSDateFormatter()
    
    func timerFired(timer: NSTimer?){
        
        guard let question = self.questionPerm else
        
        { return }
        
        formatter.dateFormat = "H:mm:ss"

        
        let dateComparisonResult: NSComparisonResult = NSDate().compare(question.timeLimit)
        if dateComparisonResult == NSComparisonResult.OrderedAscending
            
        {
            submitResponseButton.setTitle("Submit Response", forState: .Normal)
            submitResponseButton.backgroundColor = UIColor(red: 133/255, green: 178/255, blue: 131/255, alpha: 1)
         
            let interval = question.timeLimit.timeIntervalSinceDate(NSDate())
            let date = NSDate(timeIntervalSince1970: interval)
            let formattedDateString = formatter.stringFromDate(date)
    
            let printLimit = question.timeLimit.timeIntervalSince1970
            //print(printLimit)
            
            let printNow = NSDate().timeIntervalSince1970
            //print(printNow)
            
            let difference: Double = printLimit - printNow
            print(difference)
          
            viewResponsesButton.setTitle("\(formattedDateString) left", forState: .Normal)
            viewResponsesButton.backgroundColor = .whiteColor()
            
        } else {
            
            submitResponseButton.setTitle(" \(question.responses.count) responses", forState: .Normal)
            submitResponseButton.backgroundColor = .whiteColor()
            viewResponsesButton.setTitle("View Responses", forState: .Normal)
            viewResponsesButton.backgroundColor = UIColor(red: 249/255, green: 81/255, blue: 197/255, alpha: 1)
        }
    }

    func loadQuestionInfo(question: Question) {
        self.questionPerm = question
        self.timerFired(nil)
        questionLabel.text = "  \(question.questionText)"
    }
    
}






