//
//  QuestionTableViewCell.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell, UITableViewDelegate {

    
    //IBOUTLET
    //presents text of RESPECTIVE QUESTION from dataPoint 2 
    
    
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
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    
}
