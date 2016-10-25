//
//  UserController.swift
//  Honest Badger
//
//  Created by Steve Cox on 8/29/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation
import Firebase

class UserController {
    
    static let currentUserKey = "currentUser"
    static let currentUserIdKey = "currentUserIdentifier"
    
    static let shared = UserController()
    
    var currentUser: User? = UserController.loadFromDefaults()
    
    var currentUserID: String {
        guard let currentUser = currentUser, let currentUserID = currentUser.identifier else {
            fatalError("Could not retrieve current user id")
        }
        return currentUserID
    }

    static func createUser(username: String, password: String, completion: @escaping (_ user: User?, _ error: NSError?) -> Void) {
            FIRAuth.auth()?.createUser(withEmail: username, password: password, completion: { (user, error) in
            if let error = error {
                print("There was error while creating user: \(error.localizedDescription)")
                completion(nil, error as NSError?)
            } else if let firebaseUser = user {
                var user = User(username: username, identifier: firebaseUser.uid)
                user.save()
                UserController.shared.currentUser = user
                UserController.saveUserInDefaults(user: user)
                completion(user, error as NSError?)
            } else {
                completion(nil, error as NSError?)
            }
        })
    }
    
    static func updateQuestionsAskedIDsForCurrentUser(_ questionID: String?, completion: (_ success: Bool) -> Void) {
        if let questionID = questionID {
            if UserController.shared.currentUser?.questionsAsked?.count != 0 {
                UserController.shared.currentUser?.questionsAsked?.append(questionID)
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("asked").child(questionID).setValue(true)
                completion(true)
            } else {
                UserController.shared.currentUser?.questionsAsked = [questionID]
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("asked").child(questionID).setValue(true)
                completion(true)
            }
        } else {
            print("Could not update User's questionsAsked array: QuestionID was nil")
            completion(false)
        }
    }
    
    static func updateQuestionsAnsweredIDsForCurrentUser(questionID: String?, completion: (_ success: Bool) -> Void) {
        if let questionID = questionID {
            if UserController.shared.currentUser?.questionsAnswered?.count != 0 {
                UserController.shared.currentUser?.questionsAnswered?.append(questionID)
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("answered").child(questionID).setValue(true)
                completion(true)
            } else {
                UserController.shared.currentUser?.questionsAnswered = [questionID]
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("answered").child(questionID).setValue(true)
                completion(true)
            }
        } else {
            print("Could not update User's questionsAnswered array: QuestionID was nil")
            completion(false)
        }
    }
    
    static func deleteQuestionsAnsweredIDsForCurrentUser(questionID: String?, completion: (_ success: Bool) -> Void) {
        if let questionID = questionID {
            if UserController.shared.currentUser?.questionsAnswered?.count != 1 {
                UserController.shared.currentUser?.questionsAnswered? = (UserController.shared.currentUser?.questionsAnswered?.filter{$0 != questionID})!
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("answered").child(questionID).removeValue()
                completion(true)
            } else {
                UserController.shared.currentUser?.questionsAnswered = []
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("answered").child(questionID).removeValue()
                completion(true)
            }
        } else {
            print("Could not delete from User's questionsAnswered array: QuestionID was nil")
            completion(false)
        }
    }
    
    static func updateChannelsMemberOfIDsForCurrentUser(channelID: String?, completion: (_ success: Bool) -> Void) {
        if let channelID = channelID {
            if (UserController.shared.currentUser?.channelsMemberOf?.count)! > 0 {
                UserController.shared.currentUser?.channelsMemberOf?.append(channelID)
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("channels").child(channelID).setValue(true)
                completion(true)
            } else {
                UserController.shared.currentUser?.channelsMemberOf = [channelID]
                //UserController.shared.currentUser?.save()
                FirebaseController.ref.child("users").child(UserController.shared.currentUserID).child("channels").child(channelID).setValue(true)
                completion(true)
            }
        } else {
            print("Could not update User's channelsMemberOf array: ChannelID was nil")
            completion(false)
        }
    }
    
    static func authUser(username: String, password: String, completion: @escaping (_ user: User?, _ error: NSError?) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: { (firebaseUser, error) in
            if let error = error {
                print("Wasn't able log user in: \(error.localizedDescription)")
                completion(nil, error as NSError?)
            } else if let firebaseUser = firebaseUser {
                UserController.fetchUserForIdentifier(identifier: firebaseUser.uid, completion: { (user) in
                    guard let user = user else {
                        completion(nil, error as NSError?)
                        return
                    }
                    UserController.shared.currentUser = user
                    UserController.saveUserInDefaults(user: user)
                    completion(user, error as NSError?)
                })
            } else {
                completion(nil, error as NSError?)
            }
        })
    }
    
    static func restoreUserIdToDevice(){
        let firuserid = FIRAuth.auth()?.currentUser?.uid
        if firuserid != nil {
            UserController.fetchUserForIdentifier(identifier: firuserid!) { (user) in
                guard let user = user else {return}
                UserController.shared.currentUser = user
                UserController.saveUserInDefaults(user: user)
            }
        }
    }
    
    static func logOutUser(){
        try! FIRAuth.auth()!.signOut()
        clearLocallySavedUserOnLogout()
        UserController.shared.currentUser = nil
    }
    
    static func fetchUserForIdentifier(identifier: String, completion: @escaping (_ user: User?) -> Void) {
        FirebaseController.ref.child("users").child(identifier).observeSingleEvent(of: .value, with: { data in
            guard let dataDict = data.value as? [String: AnyObject],
                let user = User(dictionary: dataDict, identifier: identifier) else {
                    completion(nil)
                    return
            }
            completion(user)
        })
    }
    
    static func isLoggedInServerTest(completion: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        if let currentUser = FIRAuth.auth()?.currentUser {
            currentUser.getTokenForcingRefresh(true) { (idToken, error) in
                if let error = error {
                    completion(false, error as NSError?)
                    print(error.localizedDescription)
                } else {
                    UserController.shared.currentUser = loadFromDefaults()
                    completion(true, nil)
                }
            }
        } else {
            completion(false, nil)
        }
    }
    
    static func clearLocallySavedUserOnLogout(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: UserController.currentUserKey)
        defaults.removeObject(forKey: currentUserIdKey)
        defaults.synchronize()
    }
    
    static func saveUserInDefaults(user: User) {
        UserDefaults.standard.set(user.dictionaryCopy, forKey: UserController.currentUserKey)
        UserDefaults.standard.set(user.identifier!, forKey: currentUserIdKey)
    }
    
    static func loadFromDefaults() -> User? {
        let defaults = UserDefaults.standard
        guard let userId = defaults.object(forKey: currentUserIdKey) as? String else {
            return nil
        }
        
        fetchUserForIdentifier(identifier: userId) { (user) in
            UserController.shared.currentUser = user
        }
        return nil
    }
}
