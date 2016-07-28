//
//  QuestionController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation
import Firebase

class QuestionController {
    
    static func submitQuestion(questionText: String, timeLimit: NSDate){
        var question = Question(questionText: questionText, timeLimit: timeLimit)
        question.save()
    }
    
    static func fetchQuestions(completion: (questions: [Question]) -> Void){
        FirebaseController.ref.child("questions").observeEventType(.Value, withBlock: { (dataSnapshot) in
            guard let dataDictionary = dataSnapshot.value as? [String: [String: AnyObject]] else {
                completion(questions: [])
                return
            }
            let questions = dataDictionary.flatMap { Question(dictionary: $1, identifier: $0) }
            completion(questions: questions)
        })
    }
}