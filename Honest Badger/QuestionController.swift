//
//  QuestionController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class QuestionController {
    
    static func submitQuestion(questionText: String){
        var question = Question(questionText: questionText, timeLimit: NSDate())
        question.save()
    }
    
    static func fetchQuestions(completion: (questions: [Question]) -> Void){
        
    }
    
    
}


//func submitQuestion(){
//auto generates questionID at dataPoint 1
//sets questionText: String at dataPoint 2
//sets timestamp: Double at datapoint 5 based on question COMPLETION time, NOT creation time (adds NOW time to TIMELIMIT entry to produce the timestamp)



