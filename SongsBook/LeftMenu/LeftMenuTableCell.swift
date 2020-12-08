//
//  LeftMenuTableCell.swift
//  SongsBook
//
//  Created by Nick Bibikov on 16.11.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class LeftMenuTableCell: UITableViewCell {
    
    func configure(_ item: SideMenuItems) {
        
       // backgroundColor = .darkGray
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.red
        self.selectedBackgroundView = backgroundView
        
        textLabel?.textColor = .white
        textLabel?.text = item.rawValue
    }
}
