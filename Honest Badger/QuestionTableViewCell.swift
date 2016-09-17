//
//  QuestionTableViewCell.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

protocol QuestionResponseDelegate: class {
    func viewResponseButtonTapped(_ sender: QuestionTableViewCell)
    func submitResponseToQuestionButtonTapped(_ sender: QuestionTableViewCell)
}

class QuestionTableViewCell: UITableViewCell, UITableViewDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitResponseButton: UIButton!
    @IBOutlet weak var viewResponsesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionLabel.font = UIFont.init(name: "Rockwell", size:21.0)
        submitResponseButton.titleLabel?.font = UIFont.init(name: "Rockwell", size: 18.0)
        viewResponsesButton.titleLabel?.font = UIFont.init(name: "Rockwell", size: 18.0)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
    }
    
    var question: Question?
    
    var timer: Timer?
    var formatter = DateComponentsFormatter()
    
    weak var delegate: QuestionResponseDelegate?
    
    func timerFired(_ timer: Timer?){
        
        guard let question = self.question else
            
        { return }
        
        let dateComparisonResult: ComparisonResult = Date().compare(question.timeLimit as Date)
        if dateComparisonResult == ComparisonResult.orderedAscending {
            
            if question.responseKeys.contains(UserController.shared.currentUserID) {
            
                submitResponseButton.setTitle("Edit Response", for: UIControlState())
                submitResponseButton.backgroundColor = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
                submitResponseButton.isEnabled = true
                
                formatter.unitsStyle = .positional
                let interval = question.timeLimit.timeIntervalSince1970 - Date().timeIntervalSince1970
                
                viewResponsesButton.setTitle(" \(formatter.string(from: interval)!) left\n to respond", for: UIControlState())
                viewResponsesButton.isEnabled = false
                viewResponsesButton.backgroundColor = UIColor.white
                
            } else {
            
                submitResponseButton.setTitle("Submit Response", for: UIControlState())
                submitResponseButton.backgroundColor = UIColor(red: 133/255, green: 178/255, blue: 131/255, alpha: 1)
                submitResponseButton.isEnabled = true
            
                formatter.unitsStyle = .positional
                let interval = question.timeLimit.timeIntervalSince1970 - Date().timeIntervalSince1970
            
                viewResponsesButton.setTitle(" \(formatter.string(from: interval)!) left\n to respond", for: UIControlState())
                viewResponsesButton.isEnabled = false
                viewResponsesButton.backgroundColor = UIColor.white
                
            }
            
        } else {
            
            submitResponseButton.setTitle(" \(question.responses.count) responses\n    received", for: UIControlState())
            submitResponseButton.backgroundColor = UIColor.white
            submitResponseButton.isEnabled = false
            
            viewResponsesButton.isEnabled = true
            viewResponsesButton.setTitle("View Responses", for: UIControlState())
            viewResponsesButton.backgroundColor = UIColor(red: 249/255, green: 81/255, blue: 197/255, alpha: 1)
        }
    }
    
    @IBAction func viewResponseButtonTapped(_ sender: UIButton) {
        self.delegate?.viewResponseButtonTapped(self)
    }
    
    @IBAction func submitResponseToQuestionButtonTapped(_ sender: UIButton) {
        self.delegate?.submitResponseToQuestionButtonTapped(self)
    }
    
    func loadQuestionInfo(_ question: Question) {
        self.question = question
        self.timerFired(nil)
        questionLabel.text = "\(question.questionText)"
    }
}
