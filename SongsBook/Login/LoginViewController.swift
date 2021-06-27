//
//  LoginVC.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 13.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    deinit { print("🔥 deinit \(K.ViewController.Login)") }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
    }
    
    // TODO: Make "Forgot Password?" later on
    @IBAction func skipForNowTapped(_ sender: UIButton) {
        LoginManager.skipLoginForNow = true
        // Remove Login Screen
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate the fields
            
            // Create cleaned version of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Login the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                // Check for errors
                if error != nil {
                    // There was an error
                    self.errorLabel.text = error?.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    // Get rid of Login screen
                    self.dismiss(animated: true, completion: nil)
                }
            }
    }
    
} // Class
