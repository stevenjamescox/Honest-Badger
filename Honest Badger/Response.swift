//
//  Response.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

struct Response: FirebaseType, Equatable{
    
    private let responseKey = "response"
    
    var question: Question
    var response: String
    var identifier: String?
    
    var endpoint: String {
    return "questions/\(question.identifier ?? "")/responses"
    }
    
    // MARK: TODO: add replaceResponseKey with autoID [from Firebase]
    var dictionaryCopy: [String: AnyObject]{
        return [responseKey: response]
    }
    
    init(question: Question, response: String){
    self.question = question
    self.response = response
    self.identifier = nil
    }

    init?(dictionary: [String: AnyObject], identifier: String){
        guard let response = dictionary[responseKey] as? String else
        { return nil }
        self.response = response
        self.identifier = identifier
    }
}

func ==(lhs: Response, rhs: Response) -> Bool {
    return lhs.response == rhs.response
}