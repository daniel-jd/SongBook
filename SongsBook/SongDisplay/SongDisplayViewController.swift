//
//  SongDisplayVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 16.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class SongDisplayViewController: UIViewController {
    
    var songToDisplay = Song()
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var keyDisplayLabel: UILabel!
    @IBOutlet weak var tempoValueLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    
    let myColor = UIColor(red: 156.0/255.0, green: 133.0/255.0, blue: 178.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupView()
        displaySong(song: songToDisplay)
    }
    
    deinit { print("🏁 - \(classForCoder)") }
    
    
//    @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
//        panel?.openLeft(animated: true)
//    }
    
    @IBAction func didTapBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup the appearence here
    
    func setupView() {
        navigationController?.navigationBar.barTintColor = myColor
    }
    
    // Setup for correct song displaying style
    func displaySong(song: Song) {
        title = "Amaing Grace" //song.title
        songTitleLabel.text = "Amazing Grace"  //song.title
        artistLabel.text = "by " + "Chris Tomlin"  //(song.artist ?? "Unknown")
        keyDisplayLabel.text = "Em" //song.key
        tempoValueLabel.text = "100" //song.tempo
        lyricsTextView.text = readSongFromFile() //song.songBody
    }
    
    //TEST: -  Read Oceans.txt file in the Project and copy its data to a String
    func readSongFromFile() -> String {
        let fileURL = Bundle.main.path(forResource: "Oceans", ofType: "txt")
        var readString = ""
        do {
            readString = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Can't read the file")
            print(error)
            return ""
        }
        return readString
    }
    
    
}
