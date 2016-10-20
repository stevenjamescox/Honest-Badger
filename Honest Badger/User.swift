//
//  User.swift
//  Honest Badger
//
//  Created by Steve Cox on 10/19/16.
//  Some code borrowed from app Steve Cox worked on called "Turnn"
//

import Foundation

class User: FirebaseType {
    
    private let usernameKey = "username"
    private let questionsAskedKey = "asked"
    private let questionsAnsweredKey = "answered"
    private let channelsMemberOfKey = "channels"
    private let identifierKey = "id"

    var username: String
    var questionsAsked: [String]?
    var questionsAnswered: [String]?
    var channelsMemberOf: [String]?
    var identifier: String?
    
    var endpoint: String {
        return "Users"
    }
    
    var dictionaryCopy: [String:AnyObject] {
        
        var dictionary: [String: AnyObject] = [usernameKey: username as AnyObject]
        
        if let questionsAsked = questionsAsked {
            dictionary.updateValue(questionsAsked as AnyObject, forKey: questionsAskedKey)
        }
        
        if let questionsAnswered = questionsAnswered {
            dictionary.updateValue(questionsAnswered as AnyObject, forKey: questionsAnsweredKey)
        }
        
        if let channelsMemberOf = channelsMemberOf {
            dictionary.updateValue(channelsMemberOf as AnyObject, forKey: channelsMemberOfKey)
        }
        return dictionary
    }
    
    init(username: String, questionsAsked: [String]? = [], questionsAnswered: [String]? = [], channelsMemberOf: [String]? = [], identifier: String) {
        
        self.username = username
        self.questionsAsked = questionsAsked.flatMap{$0}
        self.questionsAnswered = questionsAnswered.flatMap {$0}
        self.channelsMemberOf = channelsMemberOf.flatMap {$0}
        self.identifier = identifier
    }
    
    required init?(dictionary: [String:AnyObject], identifier: String) {
        
        guard let username = dictionary[usernameKey] as? String
            else { return nil }
        
        if let questionsAsked = dictionary[questionsAskedKey] as? [String] {
            self.questionsAsked = questionsAsked
            print("questions asked: \(questionsAsked)")
        }
        
        if let questionsAnswered = dictionary[questionsAnsweredKey] as? [String] {
            self.questionsAnswered = questionsAnswered
            print("questions answered: \(questionsAnswered)")
        }
        
        if let channelsMemberOf = dictionary[channelsMemberOfKey] as? [String] {
            self.channelsMemberOf = channelsMemberOf
            print("channels member of: \(channelsMemberOf)")
        }
        
        self.identifier = identifier
        self.username = username
    }
}
