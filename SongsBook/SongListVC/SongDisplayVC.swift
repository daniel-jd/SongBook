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
        print("Song Display called")
        showSong(song: songToDisplay)
    }
    
    func showSong(song: Song) {
        let fs = ChordPro.parse(song.lyrics!)
        print("formated: \(fs)")
        title = song.title
        songTitleLabel.text = song.title
        artistLabel.text = "by " + (song.artist ?? "Unknown")
        keyDisplayLabel.text = song.key
        tempoValueLabel.text = song.tempo
        lyricsTextView.text = song.lyrics
    }
    
    
    
}
