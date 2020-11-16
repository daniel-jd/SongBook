//
//  SongDisplayVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 16.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class SongDisplayVC: UIViewController {
    
    var songToDisplay = Song()
    
    private let songsListVC = SongsListVC()
    private let playlistVC  = PlaylistVC()
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var keyDisplayLabel: UILabel!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var tempoValueLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LeftMenuConfig.shared.addGestureForMenu(view)
        addChildControllers()
        
//        print("Song Display called")
//        displaySong(song: songToDisplay)
    }
    
    deinit { print("🏁 - \(classForCoder)") }
    
    
    @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
        guard let menu = LeftMenuConfig.shared.sideMenu else { return }
        present(menu, animated: true)
    }
    
    
    private func addChildControllers() {
        addChild(songsListVC)
        addChild(playlistVC)
        
        view.addSubview(songsListVC.view)
        view.addSubview(playlistVC.view)
        
        songsListVC.view.frame = view.bounds
        playlistVC.view.frame = view.bounds
        
        songsListVC.didMove(toParent: self)
        playlistVC.didMove(toParent: self)
        
        songsListVC.view.isHidden = true
        playlistVC.view.isHidden = true
    }
    
    
    func displaySong(song: Song) {
        let fs = ChordPro.parse(song.songBody!)
        print("formated: \(fs)")
        title = song.title
        songTitleLabel.text = song.title
        artistLabel.text = "by " + (song.artist ?? "Unknown")
        keyDisplayLabel.text = song.key
        tempoValueLabel.text = song.tempo
        lyricsTextView.text = song.songBody
    }
    
    
    func didSelectMenuItem(named: SideMenuItems) {
        
        LeftMenuConfig.shared.sideMenu?.dismiss(animated: true, completion: nil)
        
        title = named.rawValue
        
        switch named {
        case .home:
            songsListVC.view.isHidden = true
            playlistVC.view.isHidden = true
        case .songs:
            songsListVC.view.isHidden = false
            playlistVC.view.isHidden = true
        case .playlist:
            songsListVC.view.isHidden = true
            playlistVC.view.isHidden = false
        }
    }
    
}
