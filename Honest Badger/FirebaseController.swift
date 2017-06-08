//
//  FirebaseController.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/18/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    static let ref = Database.database().reference()
}

protocol FirebaseType {
    var endpoint: String {get}
    var identifier: String? {get set}
    var dictionaryCopy: [String: AnyObject] {get}
    
    init?(dictionary: [String: AnyObject], identifier: String)
    
    mutating func save()
             func delete()
}

extension FirebaseType {
    
    mutating func save() {
        var newEndpoint = FirebaseController.ref.child(endpoint)
        if let identifier = identifier {
            newEndpoint = newEndpoint.child(identifier)
        } else {
            newEndpoint = newEndpoint.childByAutoId()
            self.identifier = newEndpoint.key
        }
        newEndpoint.updateChildValues(dictionaryCopy)
    }
    
    func delete() {
        guard let identifier = identifier else {
            return
        }
        FirebaseController.ref.child(endpoint).child(identifier).removeValue()
    }
}
