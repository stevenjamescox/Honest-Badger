//
//  Response.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

struct Response: Equatable{
    
    
    private let responseKey = "response"

    var response: String
    var identifier: String?
    
    var dictionaryCopy: [String: AnyObject]{
        return [responseKey: response]
    }
    
    init(response: String){
        
    self.response = response
    self.identifier = nil
    }


}

func ==(lhs: Response, rhs: Response) -> Bool {
    return lhs.response == rhs.response
}