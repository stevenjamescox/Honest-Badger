//
//  Question.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class Question: FirebaseType {
    
    private let questionTextKey = "questionText"
    private let responsesKey = "responses"
    private let timestampKey = "timestamp"
    private let timeLimitKey = "timeLimit"
    
    var questionText: String
    var responses: [String]
    var timestamp: NSDate
    var timeLimit: NSDate
    var identifier: String?
    
    var endpoint: String{
        return "questions"
    }
    
   var dictionaryCopy: [String: AnyObject] {
        return [questionTextKey: questionText, timestampKey: timestamp.timeIntervalSince1970, timeLimitKey: timeLimit.timeIntervalSince1970 ]
    }
    
    
    init(questionText: String, timeLimit: NSDate, responses: [String] = []){
        
        self.questionText = questionText
        self.responses = []
        self.timestamp = NSDate()
        self.timeLimit = timeLimit
        self.identifier = nil
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String){
        guard let questionText = dictionary[questionTextKey] as? String else
        { return nil }
        self.questionText = questionText
        self.identifier = identifier
        
        if let responsesArray = dictionary[responsesKey] as? [String: String] {
            responses = responsesArray.flatMap { $0.1 } // Randomize order?
        } else {
            responses = []
        }
        
        if let timestampInterval = dictionary[timestampKey] as? NSTimeInterval {
            self.timestamp = NSDate(timeIntervalSince1970: timestampInterval)
        } else {
            self.timestamp = NSDate()
        }
        
        if let timeLimitInterval = dictionary[timeLimitKey] as? NSTimeInterval {
            self.timeLimit = NSDate(timeIntervalSince1970: timeLimitInterval)
        } else {
            self.timeLimit = NSDate()
        }
    }
}