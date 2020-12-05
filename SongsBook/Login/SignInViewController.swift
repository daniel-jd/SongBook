//
//  SignInVC.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 14.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dontSignInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dontSignInTapped(_ sender: Any) {
        // Switch to SongBook Storyboard
        let storyboard = UIStoryboard(name: Constants.Storyboard.SongsList, bundle: nil)
        let navMenuVC = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController = navMenuVC
    }
}
