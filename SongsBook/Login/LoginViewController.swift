//
//  LoginVC.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 13.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
//import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate the fields
            
            // Create cleaned version of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Login the user
//            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//                
//                // Check for errors
//                if error != nil {
//                    // There was an error
//                    self.errorLabel.text = error?.localizedDescription
//                    self.errorLabel.alpha = 1
//                }
//                else {
//                    // Switch to another Storyboard
//                    let storyboard = UIStoryboard(name: Constants.Storyboard.SongsList, bundle: nil)
//                    let navMenuVC = storyboard.instantiateInitialViewController()
//                    self.view.window?.rootViewController = navMenuVC
//                }
//            }
    }
    
} // Class
