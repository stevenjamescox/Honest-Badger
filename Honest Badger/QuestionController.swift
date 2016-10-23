//
//  QuestionController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class QuestionController {
    
    static func submitQuestion(_ questionText: String, timeLimit: Date, completion: (_ success: Bool, _ questionID: String?) -> Void){
        var question = Question(questionText: questionText, timeLimit: timeLimit, authorID: UserController.shared.currentUserID)
        question.save()
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
    
    static func fetchQuestionsUserHasAsked(_ questionIDs: [String], _ completion: @escaping (_ questions: [Question]) -> Void){
        for questionID in questionIDs{
        FirebaseController.ref.child("questions").queryEqual(toValue: questionID).observe(.value, with: { (dataSnapshot) in
            guard let dataDictionary = dataSnapshot.value as? [String: [String: AnyObject]] else {
                completion([])
                return
            }
            let questions = dataDictionary.flatMap { Question(dictionary: $1, identifier: $0) }
            completion(questions)
        })
        }
    }
    
    
    static func fetchQuestionsUserHasAskedKeys(_ completion: @escaping (_ askedQuestionsKeys: [String]) -> Void){
        var askedQuestionsKeys: [String] = []
        
        FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("Asked").observe(.value, with: { (dataSnapshot) in
    
            guard let dataDictionary = dataSnapshot.value as? [String : AnyObject] else {
                completion([])
                return
            }
            askedQuestionsKeys = dataDictionary.flatMap {$0.0}
            completion(askedQuestionsKeys)
        })
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
