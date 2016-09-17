//
//  ResponseController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/19/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

class ResponseController{

    static func submitResponse(_ question: Question, responseText: String){
        FirebaseController.ref.child("questions").child(question.identifier ?? "").child("responses").child(UserController.shared.currentUserID).setValue(responseText)
    }
    
    static func deleteResponse(_ question: Question){
        FirebaseController.ref.child("questions").child(question.identifier ?? "").child("responses").child(UserController.shared.currentUserID).removeValue()
    }
    
    static func getSingleResponse(_ question: Question, completion: @escaping (_ singleResponse: String?) -> Void) {
        var singleResponse = ""
        let singleResponseFetch = DispatchGroup()
        singleResponseFetch.enter()
        FirebaseController.ref.child("questions").child(question.identifier ?? "").child("responses").child(UserController.shared.currentUserID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let retreivedSingleResponse = snapshot.value as? String {
            singleResponse = retreivedSingleResponse
            singleResponseFetch.leave()
            }
        })
        singleResponseFetch.notify(queue: DispatchQueue.main) {
            completion(singleResponse)
        }
    }
}
