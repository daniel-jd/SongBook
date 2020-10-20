//
//  Song.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 13.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import Foundation
import Firebase

enum Key: String, Codable {
    case A = "A"; case A_flat = "Ab"; case A_sharp = "A#"
    case B = "B"; case B_flat = "Bb";
    case C = "C"; case C_flat = "Cb"; case C_sharp = "C#"
    case D = "D"; case D_flat = "Db"; case D_sharp = "D#"
    case E = "E"; case E_flat = "Eb";
    case F = "F"; case F_sharp = "F#"
    case G = "G"; case G_flat = "Gb"; case G_sharp = "G#"
 }

// NOTE: need to deside whether use struct or class for Song!

struct Song: Codable {
// Properties
    var title: String = "Untitled"
    var artist: String = "Unknown"
    var key: String = ""
    var tempo: String = ""
    var lyrics: String = ""
    // TODO: Change tempo type to Int

}

typealias songsCallback = ([Song]) -> ()

// Dummy data
extension Song {
    
    func fetchSongs(_ callback: @escaping songsCallback) {
        
        let songsCollection = Firestore.firestore().collection("songs")
        
        songsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                // There was an error
                print("Error while getDocuments: \(error)")
            }
            else {
                // Successful getting documents
                guard let snapshot = querySnapshot else { return }
                
                var songs = [Song]()
                
                // Parsing document to a struct
                var i = 0
                for document in snapshot.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? "Untitled"
                    let artist = data["artist"] as? String ?? "Unknown"
                    let key = data["key"] as? String ?? ""
                    let tempo = data["tempo"] as? String ?? ""
                    let lyrics = data["lyrics"] as? String ?? ""
                    let newSong = Song(title: title, artist: artist, key: key, tempo: tempo, lyrics: lyrics)
                    songs.append(newSong)
                    print("Song \(i) created \(songs[i].title)")
                    i += 1
                }
                
                callback(songs)
            }
                
        }
    }
}
