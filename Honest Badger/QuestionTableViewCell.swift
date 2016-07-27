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
    
    //func hasTimePasssed
    //checks to see if timestamp has passed for RESPECTIVE QUESTION
    //this function will be called in the following four places:
    
    
    //IBAction didPressViewResponses{}
    //checks to see if timestamp has passed for RESPECTIVE QUESTION
    // if it HASN'T the segue (AKA button functionality) IS NOT active
    // if it HAS, the segue IS active
    
    //IBOutlet viewResponsesButton UIButton
    //checks to see if timestamp has passed for RESPECTIVE QUESTION
    // if it HASN'T the button text shows the time left (difference between ENDtimestamp and NOW)
    // if it HAS, it has the appearance as shown in storyboard
    
    
    //IBAction didPressSubmitResponse{}
    //checks to see if timestamp has passed for RESPECTIVE QUESTION
    //if it HAS, the segue (AKA functionality) is NOT active
    //if it HASN'T, the segue IS active
    
    //IBOoutlet submitResponseButton UIBUTTON
    //checks to see if timestamp has passed for RESPECTIVE QUESTION
    //if it HAS, the button text shows the number of responses, aquiring a ".count" from the dataPoint 4 using the countResponses() function in ResponseController
    //if it HASN'T, it has the appearance as shown in the storyboard
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var timer: NSTimer?
    
    var questionPerm: Question?
    
    var formatter = NSDateFormatter()
    
    var formatter2 = NSDateIntervalFormatter()
    
    func timerFired(timer: NSTimer?){
        
        guard let question = self.questionPerm else
        
        { return }
        
        formatter.dateFormat = "H:mm:ss"
        formatter2.dateTemplate = "H:mm:ss"
        
        
        let interval = question.timeLimit.timeIntervalSinceDate(NSDate())
        print(interval)
        //if now > question.timeLimit.timeIntervalSince1970
        
        let dateComparisonResult: NSComparisonResult = NSDate().compare(question.timeLimit)

        if dateComparisonResult == NSComparisonResult.OrderedDescending
            
        {
            submitResponseButton.setTitle("Submit Response", forState: .Normal)
            submitResponseButton.backgroundColor = UIColor(red: 133/255, green: 178/255, blue: 131/255, alpha: 1)
            
            
            /*let now = NSDate().timeIntervalSince1970
             let unixTimeDiff = "\(now - question.timeLimit.timeIntervalSince1970)" as String
            print(unixTimeDiff)
            */
            
            
            func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
                
                let ti = NSInteger(interval)
                
                let ms = Int((interval % 1) * 1000)
                
                let seconds = ti % 60
                let minutes = (ti / 60) % 60
                let hours = (ti / 3600)
                
                return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
            }
            
            let timeLeft = stringFromTimeInterval(interval)
 
            viewResponsesButton.setTitle("\(timeLeft) left", forState: .Normal)
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
   
    
    
    

