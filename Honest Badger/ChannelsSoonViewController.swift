//
//  ChannelsSoonViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 9/21/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class ChannelsSoonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barTintColor = UIColor.badgerBlue()
        navigationController!.navigationBar.tintColor = UIColor.black
        
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
