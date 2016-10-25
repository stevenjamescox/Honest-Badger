//
//  QuestionController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class QuestionController {
    
    var questions: [Question] = []
    
    static let sharedController = QuestionController()
    
    static func submitQuestion(_ questionText: String, timeLimit: Date, completion: @escaping (_ success: Bool, _ questionID: String?) -> Void){
        var question = Question(questionText: questionText, timeLimit: timeLimit, authorID: UserController.shared.currentUserID)
        question.save()
        if let questionID = question.identifier {
            completion(true, questionID)
        }
        else {
            completion(false, nil)
        }
    }
    
    static func fetchQuestions(_ completion: @escaping (_ questions: [Question]) -> Void){
        FirebaseController.ref.child("questions").observe(.value, with: { (dataSnapshot) in
            guard let dataDictionary = dataSnapshot.value as? [String: [String: AnyObject]] else {
                completion([])
                return
            }
            let questions = dataDictionary.flatMap { Question(dictionary: $1, identifier: $0) }
            completion(questions)
        })
    }
    
    static func fetch200Questions(_ completion: @escaping (_ questions: [Question]) -> Void){
        FirebaseController.ref.child("questions").queryLimited(toLast: 200).observe(.value, with: { (dataSnapshot) in
            guard let dataDictionary = dataSnapshot.value as? [String: [String: AnyObject]] else {
                completion([])
                return
            }
            let questions = dataDictionary.flatMap { Question(dictionary: $1, identifier: $0) }
            completion(questions)
        })
    }
    
//    static func fetchQuestionsUserHasAsked(_ questionIDs: [String], _ completion: @escaping (_ questions: [Question]) -> Void){
//        for questionID in questionIDs{
//        FirebaseController.ref.child("questions").queryEqual(toValue: questionID).observe(.value, with: { (dataSnapshot) in
//            guard let dataDictionary = dataSnapshot.value as? [String: [String: AnyObject]] else {
//                completion([])
//                return
//            }
//            let questions = dataDictionary.flatMap { Question(dictionary: $1, identifier: $0) }
//            completion(questions)
//        })
//        }
//    }
//    
//    
//    static func fetchQuestionsUserHasAskedKeys(_ completion: @escaping (_ askedQuestionsKeys: [String]) -> Void){
//        var askedQuestionsKeys: [String] = []
//        
//        FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("Asked").observe(.value, with: { (dataSnapshot) in
//    
//            guard let dataDictionary = dataSnapshot.value as? [String : AnyObject] else {
//                completion([])
//                return
//            }
//            askedQuestionsKeys = dataDictionary.flatMap {$0.0}
//            completion(askedQuestionsKeys)
//        })
//    }
    
    static func fetchAskedQuestionsForUserID(uid: String, completion: @escaping (_ questions: [Question]?) -> Void) {
        let users = FirebaseController.ref.child("users")
        users.child(UserController.shared.currentUserID).child("asked").observe(.value, with: { (snapshot) in
            if let questionDictionary = snapshot.value as? [String : AnyObject] {
                let questionIDs = questionDictionary.flatMap({ ($0.0) })
                fetchQuestionsThatMatchQuery(questionIDs: questionIDs, completion: { (questions) in
                    completion(questions)
                })
            } else {
                completion(nil)
            }
        })
    }
    
    static func fetchAnsweredQuestionsForUserID(uid: String, completion: @escaping (_ questions: [Question]?) -> Void) {
        let users = FirebaseController.ref.child("users")
        users.child(UserController.shared.currentUserID).child("answered").observe(.value, with: { (snapshot) in
            if let questionDictionary = snapshot.value as? [String : AnyObject] {
                let questionIDs = questionDictionary.flatMap({ ($0.0) })
                fetchQuestionsThatMatchQuery(questionIDs: questionIDs, completion: { (questions) in
                    completion(questions)
                })
            } else {
                completion(nil)
            }
        })
    }
    
    static func fetchQuestionsThatMatchQuery(questionIDs: [String], completion: @escaping (_ questions: [Question]?) -> Void) {
        var questions: [Question] = []
        
        let questionFetchGroup = DispatchGroup()
        
        for questionID in questionIDs {
            questionFetchGroup.enter()
            FirebaseController.ref.child("questions").child(questionID).observe(.value, with: { (snapshot) in
                if let questionDictionary = snapshot.value as? [String : AnyObject], let question = Question(dictionary: questionDictionary, identifier: questionID) {
                    questions.append(question)
                }
                questionFetchGroup.leave()
            })
        }
        questionFetchGroup.notify(queue: DispatchQueue.main) {
            completion(questions)
        }
    }
    
    //    static func fetchQuestionsThatMatchQuery(_ questionIDs: [String], completion: @escaping (_ questions: [Question]?) -> Void) {
    //
    //        var questions: [Question] = []
    //
    //        let questionFetchGroup = DispatchGroup()
    //            for questionID in questionIDs {
    //                questionFetchGroup.enter()
    //                FirebaseController.ref.child("questions").child(questionID).observeSingleEvent(of: .value, with: { (snapshot) in
    //
    //
    //                    if let questionDictionary = snapshot.value as? [String: AnyObject], let question = Question(dictionary: questionDictionary, identifier: questionID) {
    //                        questions.append(question)
    //                }
    //                    questionFetchGroup.leave()
    //            })
    //        }
    //        questionFetchGroup.notify(queue: DispatchQueue.main) {
    //            completion(questions)
    //        }
    //    }
}
