//
//  ActionTableViewCell.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class ActionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var leftSideView: UIView!
    
    @IBOutlet weak var rightSideView: UIView!
    
    @IBOutlet weak var submitResponseOutlet: UIButton!
    
    @IBOutlet weak var ViewResponseOutlet: UIButton!
    
    // MARK: - Actions
    
   
    @IBAction func didPressSubmitButton(sender: AnyObject) {
    }
    
    @IBAction func didPressViewButton(sender: AnyObject) {
    }
    
    
    
    
    

}
