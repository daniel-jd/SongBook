//
//  SignInVC.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 14.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dontSignInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit { print("🔥 deinit \(K.ViewController.SignIn)") }
    
    @IBAction func dontSignInTapped(_ sender: Any) {
        LoginManager.skipLoginForNow = true
        // Remove Login Screen
        dismiss(animated: true, completion: nil)
    }
}
