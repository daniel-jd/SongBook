//
//  Constants.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 15.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

struct K {
    
    struct Storyboard {
        
        static let Login = "LoginViewController"
        static let LeftMenu = "LeftMenuViewController"
        static let SongsList = "SongsListViewController"
        static let AddSong = "AddSongViewController"
        static let SongDisplay = "SongDisplayViewController"
        static let Setlist = "SetlistViewController"
    }
    
    struct ViewController {
        
        static let Login = "LoginViewController"
        static let SignIn = "SignInViewController"
        static let SignUp = "LoginViewController"
        static let LeftMenu = "LeftMenuViewController"
        static let SongsList = "SongsListViewController"
        static let AddSong = "AddSongViewController"
        static let SongDisplay = "SongDisplayViewController"
        static let Playlist = "PlaylistViewController"
    }
    
    // Firestore Database names for collections, documents and fields
    struct DB {
        // users collection
        static let users = "users"
        static let users_email = "email"
        static let users_password = "password"
        static let users_firstname = "firstname"
        static let users_lastname = "lastname"
        static let users_uid = "uid"
        
        // songs collection
        static let songs = "songs"
        static let song_title = "title"
        static let song_artist = "artist"
        static let song_key = "key"
        static let song_tempo = "tempo"
        static let song_songBody = "songBody"
    }
}
