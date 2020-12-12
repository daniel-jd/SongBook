//
//  SongDisplayVC.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 16.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
import FirebaseAuth

class SongDisplayViewController: UIViewController, UITextViewDelegate {
    
    var song = Song()
    var textView: UITextView!
    var textStorage: SyntaxHighlightTextStorage!
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var keyDisplayLabel: UILabel!
    @IBOutlet weak var tempoValueLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    
    let myColor = UIColor(red: 156.0/255.0, green: 133.0/255.0, blue: 178.0/255.0, alpha: 1.0)
    
    // TODO: Нужно задать это ГЛОБАЛЬНО!
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("❤️ view will appear")
        checkIfUserIsLogined()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🐰 view did load")
        
        // Custom TextView
        createTextView()

        textView.isScrollEnabled = true
        navigationController?.navigationBar.barStyle = .black
        textView.adjustsFontForContentSizeCategory = true
        
        checkIfUserIsLogined()
        //setupView()
        displaySong(song: song)
    }
    
    override func viewDidLayoutSubviews() {
      textStorage.update()
    }
    
    deinit { print("🔥 deinit \(Constants.ViewController.SongDisplay)") }
    
    
//    @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
//        panel?.openLeft(animated: true)
//    }
    
    @IBAction func didTapBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func createTextView() {
      // 1
      let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
      let attrString = NSAttributedString(string: song.songBody!, attributes: attrs)
      textStorage = SyntaxHighlightTextStorage()
      textStorage.append(attrString)
      
      let newTextViewRect = view.bounds
      
      // 2
      let layoutManager = NSLayoutManager()
      
      // 3
      let containerSize = CGSize(width: newTextViewRect.width, height: .greatestFiniteMagnitude)
      let container = NSTextContainer(size: containerSize)
      container.widthTracksTextView = true
      layoutManager.addTextContainer(container)
      textStorage.addLayoutManager(layoutManager)
      
      // 4
      textView = UITextView(frame: newTextViewRect, textContainer: container)
      textView.delegate = self
      view.addSubview(textView)
      
      // 5
      textView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        textView.topAnchor.constraint(equalTo: view.topAnchor),
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
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
        //lyricsTextView.text = str
        textView.text = str
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
            print("☀️ User is Logged-In")
        } else {
            //User Not logged in
            print("⚡️ User is NOT Logged-In")
            showLoginScreen()
        }
    }
    
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Login, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        present(vc!, animated: true, completion: nil)
    }
    
    
}
