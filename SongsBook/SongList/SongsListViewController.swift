//
//  TableViewController.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 15.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
import Firebase

class SongsListViewController: UITableViewController, AddSongDelegate {
    
    public var songsList = [Song]()
    //var numberOfSongs: Int?
    
    // This should change status bar to light color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
   
        print("🍄 viewDidLoad called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate() // DOSEN'T WORK!!!
        loadSongsFromDatabase()
    }
    
    deinit { print("🔥 deinit \(K.ViewController.SongsList)") }
    
    @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
        panel?.openLeft(animated: true)
    }
    
    @IBAction func addSongButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: K.Storyboard.AddSong, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: K.ViewController.AddSong) as! AddSongViewController
        vc.addSongDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    private func loadSongsFromDatabase() {
        let songManager = SongManager()
        songManager.fetchSongs({ [weak self] songs in
            self?.songsList = songs
            self?.tableView.reloadData()
        })
    }
    
    func addNewSong(song: Song) {
        songsList.append(song)
        let newIndexPath = IndexPath(row: songsList.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    // TODO: - Save local songsList
    func saveSongsListToUserDefaults() {
        print("saveSongsListToUserDefaults() called")
    }
    
    private func setTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 72.0
        tableView.rowHeight = 72
        title = "Songs"
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Say that we'll use our own custom cell from SongCell class
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.SongCell, for: indexPath) as! SongCell
        let song = songsList[indexPath.row]
        cell.set(song: song)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Programmatic way of transition to another screen
        let storyboard = UIStoryboard(name: K.Storyboard.SongDisplay, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: K.ViewController.SongDisplay) as! SongDisplayViewController
        
        // TODO: Probably this could be substitute with a delegate or another function
        vc.song.title = songsList[indexPath.row].title
        vc.song.artist = songsList[indexPath.row].artist
        vc.song.key = songsList[indexPath.row].key
        vc.song.tempo = songsList[indexPath.row].tempo
        vc.song.songBody = songsList[indexPath.row].songBody
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            songsList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
        
} // Class
