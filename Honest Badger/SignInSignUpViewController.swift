//
//  SignInSignUpViewController.swift
//  Honest Badger
//
//  Created by Steve Cox on 8/3/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInSignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak private var forgetPasswordButtonOutlet: UIButton!
    
    @IBOutlet weak private var legalAndPrivacyButtonOutlet: UIButton!
    
    @IBOutlet weak private var haveAccountButton: UIButton!
    
    @IBOutlet weak private var signUpOrInButtonOutlet: UIButton!
    
    @IBOutlet weak private var emailField: UITextField!
    @IBOutlet weak private var passwordField: UITextField!
    
    @IBOutlet weak private var loginOrSignUpButtonOutlet: UIButton!
    
    var isSignInPage = true
    
    func setDelegatesForTextFields() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgetPasswordButtonOutlet.isHidden = false
        forgetPasswordButtonOutlet.isEnabled = true
        
        setDelegatesForTextFields()
        
        haveAccountButton.setTitle("Don't have an account?", for: .normal)
        loginOrSignUpButtonOutlet.setTitle("Login", for: .normal)
        signUpOrInButtonOutlet.setTitle("Sign Up", for: .normal)
        
        forgetPasswordButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 11.0)
        forgetPasswordButtonOutlet.titleLabel?.textAlignment = NSTextAlignment.center
        
        legalAndPrivacyButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 11.0)
        legalAndPrivacyButtonOutlet.titleLabel?.textAlignment = NSTextAlignment.center
        
        loginOrSignUpButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 17.0)
        
        signUpOrInButtonOutlet.titleLabel?.font = UIFont.init(name: "Rockwell", size: 15.0)
        haveAccountButton.titleLabel?.font = UIFont.init(name: "Rockwell", size: 15.0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.characters.count + string.characters.count - range.length
        if textField == emailField {
            return newLength <= 35
        } else if textField == passwordField {
            return newLength <= 25
        }
        return true
    }
  
    func updateLoginView() {
        if isSignInPage == true  {
            UIView.animate(withDuration: 0.25){
                self.haveAccountButton.setTitle("Already have an account?", for: .normal)
            }
            forgetPasswordButtonOutlet.isHidden = true
            forgetPasswordButtonOutlet.isEnabled = false
            loginOrSignUpButtonOutlet.setTitle("Create Account", for: .normal)
            signUpOrInButtonOutlet.setTitle("Sign In", for: .normal)
            isSignInPage = false
        } else {
            UIView.animate(withDuration: 0.25){
                self.haveAccountButton.setTitle("Don't have an account?", for: .normal)
            }
            forgetPasswordButtonOutlet.isHidden = false
            forgetPasswordButtonOutlet.isEnabled = true
            loginOrSignUpButtonOutlet.setTitle("Login", for: .normal)
            signUpOrInButtonOutlet.setTitle("Sign Up", for: .normal)
            isSignInPage = true
        }
    }
    
    func signUp() {
        if let email = emailField.text , emailField.text != "",
            let password = passwordField.text , passwordField.text != "" {
            UserController.createUser(username: email, password: password, completion: { (user, error) in
                UserController.shared.currentUser = user
                if UserController.shared.currentUser != nil {
                    self.performSegue(withIdentifier: "loginScreenToGlobalSegue", sender: self)
                    self.emailField.text = ""
                    self.passwordField.text = ""
                    self.updateLoginView()
                    self.loginOrSignUpButtonOutlet.isEnabled = true
                } else {
                    if error != nil {
                        if let errCode = FIRAuthErrorCode(rawValue: error!.code) {
                            switch errCode {
                            case .errorCodeTooManyRequests:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Too many recent account creation attempts from your device. Please wait a little while and try again.")
                            case .errorCodeInvalidEmail:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Invalid email address, please correct the address you entered and again.")
                            case .errorCodeWeakPassword:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Password is too short and/or weak. Please make your password at least eight characters,\nand include at least one upper-case letter, one lower-case letter, and one number")
                            case .errorCodeEmailAlreadyInUse:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "An account already exists for this email address. Please choose 'sign in' at the bottom of the page to login to your account.")
                            case .errorCodeInternalError:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Internal error. Please try again.")
                            case .errorCodeNetworkError:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Not able to connect to the network. Please test your connection and try again.")
                            default:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Account creation failed due to an unexpected error. 💩")
                            }
                        }
                        self.loginOrSignUpButtonOutlet.isEnabled = true
                    }
                }
            })
        } else {
            self.loginOrSignUpButtonOutlet.isEnabled = true
        }
    }
    
    func login() {
        if let email = emailField.text , emailField.text != "",
            let password = passwordField.text , passwordField.text != "" {
            UserController.authUser(username: email, password: password, completion: { (user, error) in
                UserController.shared.currentUser = user
                if UserController.shared.currentUser != nil {
                    self.performSegue(withIdentifier: "loginScreenToGlobalSegue", sender: self)
                    self.emailField.text = ""
                    self.passwordField.text = ""
                    self.loginOrSignUpButtonOutlet.isEnabled = true
                } else {
                    if error != nil {
                        if let errCode = FIRAuthErrorCode(rawValue: error!.code) {
                            switch errCode {
                            case .errorCodeTooManyRequests:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Too many recent login attempts from your device. Please wait a little while and try again.")
                            case .errorCodeInvalidEmail:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Invalid email address, please try again.")
                            case .errorCodeWrongPassword:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Invalid password, please try again. If you forgot your password, please use the 'forgot password' button below.")
                            case .errorCodeUserDisabled:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Your account has been disabled, likely for the creation of inappropriate questions and/or responses. Email an explanation to 'appeals@honestbadger.com' to request that your account be re-enabled.")
                            case .errorCodeInternalError:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Internal error. Please try again.")
                            case .errorCodeNetworkError:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Not able to connect to the network. Please test your connection and try again.")
                            case .errorCodeUserNotFound:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "User not found! The account may not exist yet. Choose 'sign up' at the bottom of the page to create an account.")
                            default:
                                self.createAlert(title: "Error: \(errCode.rawValue)", message: "Login failed due to an unexpected error. 💩")
                            }
                        }
                        self.loginOrSignUpButtonOutlet.isEnabled = true
                    }
                }
            })
        } else {
            self.loginOrSignUpButtonOutlet.isEnabled = true
        }
    }
    
    
    @IBAction func altToggleSignUpOrInButtonTapped(_ sender: AnyObject) {
        updateLoginView()
    }
    
    @IBAction func toggleSignUpOrInButtonTapped(_ sender: AnyObject) {
        updateLoginView()
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        self.loginOrSignUpButtonOutlet.isEnabled = false
        if isSignInPage == false {
            signUp()
        } else {
            login()
        }
    }
    
    @IBAction func forgetPasswordButtonTapped(sender: AnyObject) {
        let prompt = UIAlertController.init(title: "Reset Password", message: "Please enter the email address associated with your Turnn account:", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "Submit", style: UIAlertActionStyle.default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordReset(withEmail: userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
            self.createAlert(title: "Request Sent", message: "If address is associated with a Turnn account, you should receive a password reset email within a few minutes.")
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        prompt.addAction(cancelAction)
        present(prompt, animated: true, completion: nil)
    }
    
    func createAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
}
