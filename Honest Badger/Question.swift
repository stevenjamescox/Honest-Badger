//
//  Question.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

struct Question: FirebaseType, Equatable {
    
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
    return [questionTextKey: questionText, timestampKey: timestamp, responsesKey: responses.map{$0.dictionaryCopy}]
    }
    
    
    init(questionText: String, responses: [Response] = []){
    
    self.questionText = questionText
    self.responses = []
    self.timestamp = NSDate()
    self.identifier = nil
    
    }
    
    init?(dictionary: [String: AnyObject], identifier: String){
            guard let questionText = dictionary[questionTextKey] as? String,
        responsesDictionaryArray = dictionary[responsesKey] as? [[String: AnyObject]] else
            { return nil }
        self.questionText = questionText
        self.responses = responsesDictionaryArray.flatMap{Response(dictionary:$0)}
        }
    }

func ==(lhs: Question, rhs: Question) -> Bool {

    return lhs.questionText == rhs.questionText && lhs.timestamp == rhs.timestamp
}
