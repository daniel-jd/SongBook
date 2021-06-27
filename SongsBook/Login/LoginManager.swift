//
//  LoginManager.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 05.04.2021.
//  Copyright © 2021 DanielYarmak. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


struct LoginManager {

    static var skipLoginForNow = false
    static var userIsSignedIn = false
    
    
    mutating func checkIfUserIsSignedIn() {
        if Auth.auth().currentUser != nil {
            print("☀️ User is Logged-In")
            LoginManager.userIsSignedIn = true
        } else {
            print("⚡️ User is NOT Logged-In")
            LoginManager.userIsSignedIn = false
        }
    }
    
}
