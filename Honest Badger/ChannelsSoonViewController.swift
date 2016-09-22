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

        navigationController!.navigationBar.barTintColor = UIColor(red: 160/255, green: 210/255, blue: 225/255, alpha: 1)
        navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
