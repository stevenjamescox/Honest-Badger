//
//  Question.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

struct Question: Equatable {
    
    private let questionTextKey = "questionText"
    private let responsesKey = "responses"
    private let timestampKey = "timestamp"
    
    var questionText: String
    var responses: [Response]
    var timestamp: NSDate
    var identifier: String?
    
    
   /* var dictionaryCopy: [String: AnyObject] {
        return [questionTextKey: questionText, timestampKey: timestamp, responsesKey: responses.map(<#T##transform: (Response) throws -> T##(Response) throws -> T#>)
    
    }*/
    
    
    init(questionText: String){
    
    self.questionText = questionText
    self.responses = []
    self.timestamp = NSDate()
    self.identifier = nil
    
    
    }
    
    init?(dictionary: [String: AnyObject], identifier: String){
    
    
    }


}

func ==(lhs: Question, rhs: Question) -> Bool {

    return lhs.questionText == rhs.questionText && lhs.timestamp == rhs.timestamp
}
