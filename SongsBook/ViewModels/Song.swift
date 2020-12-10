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


enum Key: String {
    case A = "A"; case A_flat = "Ab"; case A_sharp = "A#"
    case B = "B"; case B_flat = "Bb";
    case C = "C"; case C_flat = "Cb"; case C_sharp = "C#"
    case D = "D"; case D_flat = "Db"; case D_sharp = "D#"
    case E = "E"; case E_flat = "Eb";
    case F = "F"; case F_sharp = "F#"
    case G = "G"; case G_flat = "Gb"; case G_sharp = "G#"
 }

/*
 
 */
public class Song /*Codable*/ { // Identifiable

// Properties
//  @DocumentID var id: String? = UUID().uuidString
    var title: String?
    var artist: String?
//    var capo: String?
    var key: String?
    var tempo: String?
    var custom = [String: String]()
    var sections = [Section]()
    var songBody: String?
//    var formatedLyrics: String?
    
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
        db.collection(Constants.DB.songs).document(newDocName).setData([
            // "title": "Song Title",  etc
            Constants.DB.song_title:    song.title!,
            Constants.DB.song_artist:   song.artist!,
            Constants.DB.song_key:      song.key!,
            Constants.DB.song_tempo:    song.tempo!,
            Constants.DB.song_songBody: song.songBody!
            
        ]) { err in
            if let err = err {
                print("🍄 Error writing document: \(err)")
            } else {
                print("☀️ Document successfully written!")
            }
        }
    }
}
