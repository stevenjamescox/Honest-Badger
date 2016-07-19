//
//  Question.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class Question: FirebaseType, Equatable {
    
    private let questionTextKey = "questionText"
    private let responsesKey = "responses"
    private let timestampKey = "timestamp"
    
    var questionText: String
    var responses: [Response]
    var timestamp: NSDate
    var identifier: String?
    
    var endpoint: String{
        return "questions"
    }
    
    var dictionaryCopy: [String: AnyObject] {
        return [questionTextKey: questionText, timestampKey: timestamp.timeIntervalSince1970, responsesKey: responses.map{$0.dictionaryCopy}]
    }
    
    
    init(questionText: String, responses: [Response] = []){
        
        self.questionText = questionText
        self.responses = []
        self.timestamp = NSDate()
        self.identifier = nil
        
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String){
        guard let questionText = dictionary[questionTextKey] as? String else
            //responsesArray = dictionary[responsesKey] as? [[String: AnyObject]] else
        { return nil }
        self.questionText = questionText
        
        //self.responses = responsesArray.flatMap{Response(dictionary: $0)}
        self.identifier = identifier
        if let responsesArray = dictionary[responsesKey] as? [[String: AnyObject]]{
            responses = responsesArray.flatMap({Response(dictionary: $0)})
        } else {
            responses = []
        }
        if let timestampInterval = dictionary[timestampKey] as? NSTimeInterval {
            self.timestamp = NSDate(timeIntervalSince1970: timestampInterval)
        } else {
            self.timestamp = NSDate()
        }
    }
}

func ==(lhs: Question, rhs: Question) -> Bool {
    return lhs.questionText == rhs.questionText && lhs.timestamp == rhs.timestamp
}
