//
//  SceneDelegate.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 13.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
import FAPanels

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
         
        if let windowScene = scene as? UIWindowScene {
                    
            let window = UIWindow(windowScene: windowScene)
            let root = FAPanelController()
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: K.Storyboard.SongsList, bundle: nil)
            let storyboard: UIStoryboard = UIStoryboard(name: K.Storyboard.LeftMenu, bundle: nil)
            //let leftMenuVC = storyboard.instantiateViewController(withIdentifier: Constants.ViewController.LeftMenu) as! LeftMenuViewController
            guard let leftMenuVC = storyboard.instantiateInitialViewController() else { return }
            //let centerVC = mainStoryboard.instantiateViewController(withIdentifier: Constants.ViewController.SongDisplay) as! SongDisplayViewController
            //let centerNavVC = UINavigationController(rootViewController: centerVC)
            
            // Делаю так чтобы навигейшн из сториборда тянулся
            guard let centerNavVC = mainStoryboard.instantiateInitialViewController() else { return }
            
            root.center(centerNavVC).left(leftMenuVC)
            window.rootViewController = root
            // Делает так что меню наезжает на основной экран поверх
            root.leftPanelPosition = .front
            // Степень затемнения экрана при открывании бокового меню
            root.configs.shadowOppacity = 0.2
            root.configs.colorForTapView = UIColor.black.withAlphaComponent(0.5)
            LeftMenuConfig.shared.confingMenu()
            self.window = window
            window.makeKeyAndVisible()
            var songBookManager = SongBookManager()
            songBookManager.run()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

