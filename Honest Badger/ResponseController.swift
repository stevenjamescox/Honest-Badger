//
//  ResponseController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/19/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation
import GameplayKit

class ResponseController{

    static func submitResponse(question: Question, responseText: String){
        let response = Response(question: question, response: responseText)
        FirebaseController.ref.child("questions").child(question.identifier ?? "").child("responses").updateChildValues(response.dictionaryCopy)
    }
    
    func fetchResponses(question: Question, completion: (responses: [Response]) -> Void){
    
    
    }
    
    


}

//func submitResponse(){
    //refers to RESPECTIVE questionID at dataPoint 1
    //checks difference between NOW(time) and RESPECTIVE question end timestamp at dataPoint5, see if it has passed
    // (if question end timestamp has passed, I'll have an alert come up or something, other wise the next two lines operate)
    //auto generates responseID at dataPoint 3
    //sets reponseText: String at dataPoint 4
//}

//func countResponses(){}
// counts the responses for a RESPECTIVE QUESTION at dataPoint 4s

//func randomizeResponses(){
    //if count from countResponses() is 3+ gathers responses(values at the various dataPoint 4s) to create an array then
    //randomizes order of array using a GameplayKit function [will I need to add this to any other 
    //this function is called on the ResponsesTableViewController just before presentation)
    
    //if count from countResponeses() is < 3 then it returns an an array with just one string that says something like "Less than three responses received. For respondents' anonymity, responses will not be presented. Please re-submit question." or something that is written MUCH better
//}