//
//  OtherListVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 17.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

enum SideMenuItems: String, CaseIterable {
    
    case home = "Home"
    case songs = "Songs"
    case setlist = "Setlist"
    
    var value: String { self.rawValue }
    var index: Int {
        switch self {
        case .home:
            return 0
        case .songs:
            return 1
        case .setlist:
            return 2
        }
    }
}

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private let menuItems: [SideMenuItems] = [.home, .songs, .setlist]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //view.backgroundColor = .darkGray
    }
}
    

extension LeftMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Select what screen to display according to the menu item selected
        let selectedItem = menuItems[indexPath.row]
        
        switch selectedItem {
        case .home:
            let storyboard = UIStoryboard(name: Constants.Storyboard.SongDisplay, bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else { return }
            panel!.center(vc)
//            LeftMenuConfig.shared.sideMenu?.show(vc, sender: nil)
            break
            
        case .songs:
            let storyboard = UIStoryboard(name: Constants.Storyboard.SongsList, bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else { return }
            panel!.center(vc)
           // LeftMenuConfig.shared.sideMenu?.pushViewController(vc, animated: nil)
            break
            
        case .setlist:
            let storyboard = UIStoryboard(name: Constants.Storyboard.Setlist, bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else { return }
            panel!.center(vc)
//            LeftMenuConfig.shared.sideMenu?.show(vc, sender: nil)
            break
            
        default:
            print("🐣catch ME!!!")
            break
        }
    }
}

extension LeftMenuViewController: UITableViewDataSource {
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableCell", for: indexPath) as! LeftMenuTableCell
        let item = menuItems[indexPath.row]
        cell.configure(item)
        return cell
    }
    
    
}
