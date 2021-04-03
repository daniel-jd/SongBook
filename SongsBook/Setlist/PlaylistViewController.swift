//
//  PlaylistVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 22.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class SetlistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
        panel?.openLeft(animated: true)
    }
}
