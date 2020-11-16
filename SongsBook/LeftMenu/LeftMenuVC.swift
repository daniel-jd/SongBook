//
//  OtherListVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 17.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

//protocol MenuControllerDelegate {
//    func didSelectMenuItem(named: SideMenuItems)
//}

enum SideMenuItems: String, CaseIterable {
    
    case home = "Home"
    case songs = "Songs"
    case playlist = "Playlist"
    
    var value: String { self.rawValue }
    var index: Int {
        switch self {
        case .home:
            return 0
        case .songs:
            return 1
        case .playlist:
            return 2
        }
    }
}

class LeftMenuVC: UITableViewController {

    private let songsListVC = SongsListVC()
    
//    public var delegate: MenuControllerDelegate?

    private let menuItems: [SideMenuItems]
    private let color = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    init(with menuItems: [SideMenuItems]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(LeftMenuTableCell.self, forCellReuseIdentifier: "LeftMenuTableCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableCell", for: indexPath) as! LeftMenuTableCell
        let item = menuItems[indexPath.row]
        cell.configure(item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        // Select what screen to display according to the menu item selected
//        let selectedItem = menuItems[indexPath.row].rawValue
//        delegate?.didSelectMenuItem(named: SideMenuItems(rawValue: selectedItem)!)
        
//        switch indexPath.item {
//        case SideMenuItems.home.index:
//            let storyboard = UIStoryboard(name: Constants.Storyboard.SongDisplay, bundle: nil)
//            guard let vc = storyboard.instantiateInitialViewController() else { return }
//            LeftMenuConfig.shared.sideMenu?.show(vc, sender: nil)
//            break
//        case SideMenuItems.songs.index:
//            let storyboard = UIStoryboard(name: Constants.Storyboard.SongsList, bundle: nil)
//            guard let vc = storyboard.instantiateInitialViewController() else { return }
//            LeftMenuConfig.shared.sideMenu?.pushViewController(vc, animated: nil)
//            break
//        case SideMenuItems.playlist.index:
//            let storyboard = UIStoryboard(name: Constants.Storyboard.Playlist, bundle: nil)
//            guard let vc = storyboard.instantiateInitialViewController() else { return }
//            LeftMenuConfig.shared.sideMenu?.show(vc, sender: nil)
//            break
//        default:
//            print("🐣catch ME!!!")
//            break
//        }
    }

}
