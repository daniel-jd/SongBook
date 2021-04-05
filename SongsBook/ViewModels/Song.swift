//
//  Song.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 13.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

struct Song {

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

}
