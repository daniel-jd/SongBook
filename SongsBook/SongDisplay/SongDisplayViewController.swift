//
//  SongDisplayVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 16.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
import FirebaseAuth

class SongDisplayViewController: UIViewController {
    
    var songToDisplay = Song()
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var keyDisplayLabel: UILabel!
    @IBOutlet weak var tempoValueLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    //@IBOutlet var songBodyLabel: UILabel!
    
    let myColor = UIColor(red: 156.0/255.0, green: 133.0/255.0, blue: 178.0/255.0, alpha: 1.0)
    
    func viewWillAppear() {
        super.viewWillAppear(true)
        print("❤️ view will appear")
        checkIfUserIsLogined()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🐰 view did load")
        checkIfUserIsLogined()
        //setupView()
        displaySong(song: songToDisplay)
    }
    
    deinit { print("🔥 deinit \(Constants.ViewController.SongDisplay)") }
    
    
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
        title = song.title
        songTitleLabel.text = song.title
        artistLabel.text = "by " + (song.artist ?? "Unknown")
        keyDisplayLabel.text = song.key
        tempoValueLabel.text = song.tempo
        //print(song.songBody!)
        let testSong = readSongFromFile()
        //let str = str.replacingOccurrences(of: "\\n", with: "\n")
        //print(testSong)
        let songParsed = ChordPro.parse(testSong)
        let str = ChordPro.formatSong(songParsed)
        //print(songParsed.sections[0].lines[0].parts)
        lyricsTextView.text = str
    }
    
    //MARK: -  Read Oceans.txt file in the Project and copy its data to a String
    func readSongFromFile() -> String {
        let fileURL = Bundle.main.path(forResource: "bad-moon-rising", ofType: "sng")
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
    
    
    func checkIfUserIsLogined() {
        if Auth.auth().currentUser != nil {
            print("☀️ User is logined")
        } else {
            //User Not logged in
            print("⚡️ User is NOT logined")
            showLoginScreen()
        }
    }
    
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Login, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        present(vc!, animated: true, completion: nil)
    }
    
    
}
