//
//  QuestionTableViewCell.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

protocol QuestionResponseDelegate: class {
    func viewResponseButtonTapped(sender: QuestionTableViewCell)
    func submitResponseToQuestionButtonTapped(sender: QuestionTableViewCell)
    func reportQuestionButtonTapped(sender: QuestionTableViewCell)
}

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
    var formatter = NSDateComponentsFormatter()
    
    weak var delegate: QuestionResponseDelegate?
    
    func timerFired(timer: NSTimer?){
        
        guard let question = self.question else
            
        { return }
        
        let dateComparisonResult: NSComparisonResult = NSDate().compare(question.timeLimit)
        if dateComparisonResult == NSComparisonResult.OrderedAscending
            
        {
            submitResponseButton.setTitle("Submit Response", forState: .Normal)
            submitResponseButton.backgroundColor = UIColor(red: 133/255, green: 178/255, blue: 131/255, alpha: 1)
            submitResponseButton.enabled = true
            
            formatter.unitsStyle = .Positional
            let interval = question.timeLimit.timeIntervalSince1970 - NSDate().timeIntervalSince1970
            
            viewResponsesButton.setTitle(" \(formatter.stringFromTimeInterval(interval)!) left\n to respond", forState: .Normal)
            viewResponsesButton.enabled = false
            viewResponsesButton.backgroundColor = .whiteColor()
            
        } else {
            
            submitResponseButton.setTitle(" \(question.responses.count) responses\n    received", forState: .Normal)
            print(question.responses.count)
            submitResponseButton.backgroundColor = .whiteColor()
            submitResponseButton.enabled = false
            
            viewResponsesButton.enabled = true
            viewResponsesButton.setTitle("View Responses", forState: .Normal)
            viewResponsesButton.backgroundColor = UIColor(red: 249/255, green: 81/255, blue: 197/255, alpha: 1)
        }
    }
    
    @IBAction func viewResponseButtonTapped(sender: UIButton) {
        self.delegate?.viewResponseButtonTapped(self)
    }
    
    @IBAction func submitResponseToQuestionButtonTapped(sender: UIButton) {
        self.delegate?.submitResponseToQuestionButtonTapped(self)
    }
    
    @IBAction func reportQuestionButtonTapped(sender: UIButton) {
        self.delegate?.reportQuestionButtonTapped(self)
    }
    
    func loadQuestionInfo(question: Question) {
        self.question = question
        self.timerFired(nil)
        questionLabel.text = "  \(question.questionText)"
    }
}