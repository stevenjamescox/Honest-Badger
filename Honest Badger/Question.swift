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
    
    fileprivate let questionTextKey = "questionText"
    fileprivate let responsesKey = "responses"
    fileprivate let timestampKey = "timestamp"
    fileprivate let timeLimitKey = "timeLimit"
    fileprivate let authorIDKey = "authorID"
    
    var questionText: String
    var responses: [String]
    var timestamp: Date
    var timeLimit: Date
    var authorID: String
    var responseKeys: [String]
    var identifier: String?
    
    var endpoint: String{
        return "questions"
    }
    
   var dictionaryCopy: [String: AnyObject] {
    return [questionTextKey: questionText as AnyObject, timestampKey: timestamp.timeIntervalSince1970 as AnyObject, timeLimitKey: timeLimit.timeIntervalSince1970 as AnyObject, authorIDKey: authorID as AnyObject]
    }
    
    init(questionText: String, timeLimit: Date, authorID: String, responses: [String] = [], responseKeys: [String] = []){
        self.questionText = questionText
        self.responses = []
        self.timestamp = Date()
        self.timeLimit = timeLimit
        self.responseKeys = []
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
            responses = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: responsesPreSort) as! [String]
        } else {
            responses = []
        }
        
        if let responseKeysArray = dictionary[responsesKey] as? [String: String] {
            responseKeys = responseKeysArray.flatMap { $0.0 }
        } else {
            responseKeys = []
        }
        
        if let timestampInterval = dictionary[timestampKey] as? TimeInterval {
            self.timestamp = Date(timeIntervalSince1970: timestampInterval)
        } else {
            self.timestamp = Date()
        }
        
        if let timeLimitInterval = dictionary[timeLimitKey] as? TimeInterval {
            self.timeLimit = Date(timeIntervalSince1970: timeLimitInterval)
        } else {
            self.timeLimit = Date()
        }
    }
}
