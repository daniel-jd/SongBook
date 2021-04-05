//
//  Song.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 13.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//


import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift


// TODO: Change it to a struct
public class Song /*Codable*/ { // Identifiable

// Properties
    
    var title: String?
    var artist: String?
    var key: String?
    var tempo: String?
    var custom = [String: String]()
    var sections = [Section]()
    var songBody: String?
    
    // Will use this later on
    enum Key: String {
        case A = "A"; case A_flat = "Ab"; case A_sharp = "A#"
        case B = "B"; case B_flat = "Bb";
        case C = "C"; case C_flat = "Cb"; case C_sharp = "C#"
        case D = "D"; case D_flat = "Db"; case D_sharp = "D#"
        case E = "E"; case E_flat = "Eb";
        case F = "F"; case F_sharp = "F#"
        case G = "G"; case G_flat = "Gb"; case G_sharp = "G#"
     }
    
// Initializers
    
    init() {
        self.title = "Untitled"
        self.artist = "Unknown"
        self.key = "No"
        self.tempo = "00"
        self.songBody = "No lyrics"
    }
    
    init(title: String?, artist: String?, key: String?, tempo: String?, songBody: String?) {
        self.title = title
        self.artist = artist
        self.key = key
        self.tempo = tempo
        self.songBody = songBody
    }

} // Song

typealias songsCallback = ([Song]) -> ()


// MARK: - Extensions

extension Song {
    
    func fetchSongs(_ callback: @escaping songsCallback) {
        
        let db = Firestore.firestore()
        let songsCollection = db.collection("songs")
        
        songsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                // There was an error
                print("⚠️⚠️ Error while getDocuments: \(error)")
            }
            else {
                // Successful getting documents
                guard let snapshot = querySnapshot else { return }

                var songs = [Song]()

                // Parsing document to a struct
                var i = 0
                for document in snapshot.documents {
                    let data = document.data()
                    let title =     data["title"] as? String ?? "Untitled"
                    let artist =    data["artist"] as? String ?? "Unknown"
                    let key =       data["key"] as? String ?? "No"
                    let tempo =     data["tempo"] as? String ?? "00"
                    let songBody =  data["songBody"] as? String ?? "Couldn't find lyrics"
                    let newSong = Song(title: title, artist: artist, key: key, tempo: tempo, songBody: songBody)
                    songs.append(newSong)
                    print("💿 Song \(i) created \(songs[i].title ?? "Noname")")
                    i += 1
                }

                callback(songs)
            }
        }
    }
    
    
    func addSongToDatabase(song: Song) {
        // Add a new document in collection "songs"
        let db = Firestore.firestore()
        let newDocName = song.title!
        db.collection(K.DB.songs).document(newDocName).setData([
            // "title": "Song Title",  etc
            K.DB.song_title:    song.title!,
            K.DB.song_artist:   song.artist!,
            K.DB.song_key:      song.key!,
            K.DB.song_tempo:    song.tempo!,
            K.DB.song_songBody: song.songBody!
            
        ]) { error in
            if let err = error {
                print("🍄 Error writing document: \(err)")
            } else {
                print("☀️ Document successfully written!")
            }
        }
    }
}
