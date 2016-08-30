//
//  Question.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation
import GameplayKit

class Question: FirebaseType {
    
    private let questionTextKey = "questionText"
    private let responsesKey = "responses"
    private let timestampKey = "timestamp"
    private let timeLimitKey = "timeLimit"
    private let authorIDKey = "authorID"
    
    var questionText: String
    var responses: [String]
    var timestamp: NSDate
    var timeLimit: NSDate
    var authorID: String
    var identifier: String?
    
    var endpoint: String{
        return "questions"
    }
    
   var dictionaryCopy: [String: AnyObject] {
    return [questionTextKey: questionText, timestampKey: timestamp.timeIntervalSince1970, timeLimitKey: timeLimit.timeIntervalSince1970, authorIDKey: authorID]
    }
    
    init(questionText: String, timeLimit: NSDate, authorID: String, responses: [String] = []){
        self.questionText = questionText
        self.responses = []
        self.timestamp = NSDate()
        self.timeLimit = timeLimit
        self.identifier = nil
        self.authorID = authorID
    }
    
    required init?(dictionary: [String: AnyObject], identifier: String){
        guard let questionText = dictionary[questionTextKey] as? String else
        { return nil }
        self.questionText = questionText
        self.identifier = identifier
        
        if let authorID = dictionary[authorIDKey] as? String {
            self.authorID = authorID
        } else {
            authorID = ""
        }
    
        if let responsesArray = dictionary[responsesKey] as? [String: String] {
            let responsesPreSort = responsesArray.flatMap { $0.1 }
            responses = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(responsesPreSort) as! [String]
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