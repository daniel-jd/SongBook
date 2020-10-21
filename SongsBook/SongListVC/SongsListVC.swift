//
//  TableViewController.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 15.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit
import Firebase

class SongsListVC: UITableViewController, AddSongDelegate {
    func saveSongsListToUserDefaults() {
        print("saveSongsListToUserDefaults() called")
    }
    
        
    public var songsList = [Song]()
    //var numberOfSongs: Int?
    
    @IBAction func addSongButton(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddSongVC") as! AddSongVC
        vc.addSongDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
//      checkForSavedSongsList()
   
        print("viewDidLoad. songsList count: \(songsList.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSongsFromDatabase()
        
        //tableView.reloadData()
    }

    private func loadSongsFromDatabase() {
        Song().fetchSongs({ [weak self] songs in
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
    
    private func setTableView() {
        tableView.rowHeight = 72
        title = "Songs"
    }
    
//    func saveSongsListToUserDefaults() {
//        let encoder = JSONEncoder()
//        if let encodedSong = try? encoder.encode(songsList) {
//            defaults.set(encodedSong, forKey: Keys.savedSong)
//        }
//    }
//    
//    func checkForSavedSongsList() {
//        if let savedSongsList = defaults.object(forKey: Keys.savedSong) as? Data {
//            let decoder = JSONDecoder()
//            if let loadedSongsList = try? decoder.decode([Song].self, from: savedSongsList) {
//                songsList.append(contentsOf: loadedSongsList)
//            }
//        }
//    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Say that we'll use our own custom cell from SongCell class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SongCell
        let song = songsList[indexPath.row]
        cell.set(song: song)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Programmatic way of transition to another screen
        let vc = storyboard?.instantiateViewController(identifier: "SongDisplayVC") as! SongDisplayVC
        // TODO: Probably this could be substitute with a delegate or another function
        vc.songToDisplay.title = songsList[indexPath.row].title
        vc.songToDisplay.artist = songsList[indexPath.row].artist
        vc.songToDisplay.key = songsList[indexPath.row].key
        vc.songToDisplay.tempo = songsList[indexPath.row].tempo
        vc.songToDisplay.lyrics = songsList[indexPath.row].lyrics
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
            //saveSongsListToUserDefaults()
        }
    }
        
} // Class
