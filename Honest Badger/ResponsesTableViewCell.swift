//
//  ResponsesTableViewCell.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/27/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

protocol ResponseReportDelegate: class {
    func reportResponseButtonTapped(sender: ResponsesTableViewCell)
}

class ResponsesTableViewCell: UITableViewCell, UITableViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var responseLabel: UILabel!
    
    weak var delegate: ResponseReportDelegate?
    
    func loadResponseInfo(response: String) {
        responseLabel.text = "  \(response)"
    }
}
