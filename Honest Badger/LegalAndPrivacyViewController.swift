//
//  LegalAndPrivacyViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 10/22/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class LegalAndPrivacyViewController: UIViewController {

    @IBOutlet weak var legalPrivacyTitleOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        legalPrivacyTitleOutlet.font = UIFont.init(name: "Rockwell", size: 26.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func doneButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
