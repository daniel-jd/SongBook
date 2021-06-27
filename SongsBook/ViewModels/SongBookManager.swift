//
//  SongBookManager.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 07.04.2021.
//  Copyright © 2021 DanielYarmak. All rights reserved.
//

import UIKit

struct SongBookManager {
    
    var loginManager = LoginManager()
    
    mutating func run() {
        
        loginManager.checkIfUserIsSignedIn()
        
        if !LoginManager.userIsSignedIn {
            showLoginScreen()
        }
    }
    
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: K.Storyboard.Login, bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            vc.modalPresentationStyle = .fullScreen
            vc.present(vc, animated: true, completion: nil)
        }
    }
    
}
