//
//  Response.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class Response: Equatable {
    
    private let responseKey = "response"
    
    var question: Question?
    var response: String
    var identifier: String?
    
    var endpoint: String {
        return "questions/\(question?.identifier ?? "")/responses"
    }
 
    var dictionaryCopy: [String: AnyObject]{
        return [FirebaseController.ref.childByAutoId().key: response]
    }
    
    init(question: Question, response: String){
        self.question = question
        self.response = response
        self.identifier = nil
    }
    
    required init?(dictionary: [String: AnyObject]) {
        self.response = dictionary.values.first as? String ?? ""
        self.identifier = dictionary.keys.first
    }
}

func ==(lhs: Response, rhs: Response) -> Bool {
    return lhs.response == rhs.response
}