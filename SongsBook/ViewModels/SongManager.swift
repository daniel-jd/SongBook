//
//  SongManager.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 05.04.2021.
//  Copyright © 2021 DanielYarmak. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift


struct SongManager {
    
    typealias songsCallback = ([Song]) -> ()
    
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
