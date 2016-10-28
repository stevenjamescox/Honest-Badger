//
//  NoResultsView.swift
//  Honest Badger
//
//  Created by Steve Cox on 10/25/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit

class NoResultsView: UIView {

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        func setupView() {
            self.layer.masksToBounds = true
            self.backgroundColor = UIColor.white
        }
}
