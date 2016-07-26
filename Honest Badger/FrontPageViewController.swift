//
//  FrontPageViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/25/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import Firebase

class FrontPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
      /*   FOR TESTING, ETC.
      QuestionController.fetchQuestions { (questions) in
            var questionArray = questions.sort {$0.timeLimit.timeIntervalSince1970 < $1.timeLimit.timeIntervalSince1970}
            print(questionArray.count)
           print(questionArray[0].questionText)
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressEnterAnonymously(sender: AnyObject) {
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            // ...
        }

    }
}