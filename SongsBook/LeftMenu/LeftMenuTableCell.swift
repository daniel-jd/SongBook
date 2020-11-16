//
//  LeftMenuTableCell.swift
//  SongsBook
//
//  Created by Nick Bibikov on 16.11.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class LeftMenuTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel?
    
    func configure(_ item: SideMenuItems) {
        
        backgroundColor = .clear
        textLabel?.textColor = .white
        textLabel?.text = item.rawValue
    }
}
