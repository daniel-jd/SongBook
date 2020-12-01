//
//  LeftMenuConfig.swift
//  SongsBook
//
//  Created by Nick Bibikov on 01.12.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import FAPanels

struct LeftMenuConfig {
    
    static let shared = LeftMenuConfig()
    var panel: FAPanelController? {
        let delegate = UIApplication.shared.delegate
        return delegate?.window??.rootViewController as? FAPanelController
    }
    
    init() {}
    
    func confingMenu() {
        
        guard let panel = panel else { return }
        panel.configs.rightPanelWidth = 80
        panel.configs.bounceOnRightPanelOpen = false

        //  Should Pan from edge? Add these lines of code,

        panel.configs.panFromEdge = false
        panel.configs.minEdgeForLeftPanel  = 70
        panel.configs.minEdgeForRightPanel = 70
    }
}
