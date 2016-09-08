//
//  ResponseController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/19/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class ResponseController{

    static func submitResponse(_ question: Question, responseText: String){
        FirebaseController.ref.child("questions").child(question.identifier ?? "").child("responses").child(UserController.shared.currentUserID).setValue(responseText)
    }
}
