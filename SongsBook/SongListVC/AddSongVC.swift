//
//  AddSongVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 22.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

protocol AddSongDelegate {
    func addNewSong(song: Song)
    func saveSongsListToUserDefaults()
}

class AddSongVC: UIViewController {
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var authorTitleTextField: UITextField!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var tempoTextField: UITextField!
    @IBOutlet weak var lyricsLabel: UILabel!
    @IBOutlet weak var lyricsTextField: UITextField!
    
    var newSong: Song?
    var addSongDelegate: AddSongDelegate?
    
    func makeNewSong() {
        print("makeNewSong called")
        let title = songTitleTextField.text ?? ""
        let artist = authorTitleTextField.text ?? ""
        let key = Key.A
        let tempo = tempoTextField.text ?? ""
        let lyrics = lyricsTextField.text ?? ""
        newSong = Song(title: title, artist: artist, key: key, tempo: tempo, lyrics: lyrics)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        makeNewSong()
        guard let newSong = newSong else { return }
        addSongDelegate?.addNewSong(song: newSong)
        addSongDelegate?.saveSongsListToUserDefaults()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
