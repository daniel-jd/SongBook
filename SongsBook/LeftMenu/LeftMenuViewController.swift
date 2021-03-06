//
//  OtherListVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 17.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
import FirebaseAuth

enum SideMenuItems: String, CaseIterable {
    
    case home = "Home"
    case songs = "Songs"
    case setlist = "Setlist"
    case signout = "Sign Out"
    
    var value: String { self.rawValue }
    var index: Int {
        switch self {
        case .home:
            return 0
        case .songs:
            return 1
        case .setlist:
            return 2
        case .signout:
            return 3
        }
    }
}

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private let menuItems: [SideMenuItems] = [.home, .songs, .setlist, .signout]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit { print("🔥 deinit \(K.ViewController.LeftMenu)") }
}
    

extension LeftMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Select what screen to display according to the menu item selected
        let selectedItem = menuItems[indexPath.row]
        
        switch selectedItem {
        case .home:
            let storyboard = UIStoryboard(name: K.Storyboard.SongDisplay, bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else { return }
            panel!.center(vc)
            break
            
        case .songs:
            let storyboard = UIStoryboard(name: K.Storyboard.SongsList, bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else { return }
            panel!.center(vc)
            break
            
        case .setlist:
            let storyboard = UIStoryboard(name: K.Storyboard.Setlist, bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else { return }
            panel!.center(vc)
            break
        
        case .signout:
            
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
            
            let storyboard = UIStoryboard(name: K.Storyboard.SongDisplay, bundle: nil)
            guard let vc = storyboard.instantiateInitialViewController() else { return }
            panel!.center(vc)
            break
        }
    }
}


// MARK: - Table view data source

extension LeftMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.LeftMenuCell, for: indexPath) as! LeftMenuTableCell
        let item = menuItems[indexPath.row]
        cell.configure(item)
        
        return cell
    }
}
