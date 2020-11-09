//
//  OtherListVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 17.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

enum MenuItem: String, CaseIterable {
    case songs = "Songs"
    case playlist = "Playlist"
    case settings = "Settings"
    case login = "Login"
    case logout = "Logout"
}

class LeftMenuVC: UITableViewController {

    private let songsListVC = SongsListVC()
    let screenTitle = "Menu"
    
// TODO: Replace with ENUM in the future
    let menuItems = [MenuItem.songs, MenuItem.playlist, MenuItem.logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = screenTitle
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Select what screen to display according to the menu item selected
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "SongsList", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "SongsListVC") as! SongsListVC
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()!
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            view.window?.rootViewController = vc
        default:
            return
        }
    }

}
