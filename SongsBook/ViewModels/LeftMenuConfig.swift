//
//  LeftMenuConfig.swift
//  SongsBook
//
//  Created by Nick Bibikov on 16.11.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import SideMenu

struct LeftMenuConfig {
    
    static let shared = LeftMenuConfig()
    
    var sideMenu: SideMenuNavigationController?
    
    private init() {
        
        let menu = LeftMenuVC(with: SideMenuItems.allCases)
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
    }
    
    func addGestureForMenu(_ view: UIView) {
        
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
}
