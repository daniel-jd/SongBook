//
//  Song.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 13.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import Foundation

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
    var key: Key?
    var tempo: String = ""
    var lyrics: String = "No lyrics for this song were found"
    // TODO: Change tempo type to Int

}

// Dumy data
extension Song {
    func fetchData() -> [Song] {
        
        let song1 = Song(title: "Oceans",
        artist: "Hillsong",
        key: Key.D,
        tempo: "72",
        lyrics: """
          You call me out upon the waters
          The great unknown where feet may fail
          And there I find You in the mystery
          In oceans deep
          My faith will stand
          
          And I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine

          Your grace abounds in deepest waters
          Your sovereign hand
          Will be my guide
          Where feet may fail and fear surrounds me
          You've never failed and You won't start now

          So I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine
          """)
        
        let song2 = Song(title: "Blessed be the name",
        artist: "Matt Redman",
        key: Key.B,
        tempo: "115",
        lyrics: """
          You call me out upon the waters
          The great unknown where feet may fail
          And there I find You in the mystery
          In oceans deep
          My faith will stand
          
          And I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine

          Your grace abounds in deepest waters
          Your sovereign hand
          Will be my guide
          Where feet may fail and fear surrounds me
          You've never failed and You won't start now

          So I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine
          """)
        
        let song3 = Song(title: "This is Amazing Grace",
        artist: "Phil Wickam",
        key: Key.E,
        tempo: "98",
        lyrics: """
          You call me out upon the waters
          The great unknown where feet may fail
          And there I find You in the mystery
          In oceans deep
          My faith will stand
          
          And I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine

          Your grace abounds in deepest waters
          Your sovereign hand
          Will be my guide
          Where feet may fail and fear surrounds me
          You've never failed and You won't start now

          So I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine
          """)
        
        let song4 = Song(title: "No Longer Slaves",
        artist: "Bethel Music",
        key: Key.F,
        tempo: "87",
        lyrics: """
          You call me out upon the waters
          The great unknown where feet may fail
          And there I find You in the mystery
          In oceans deep
          My faith will stand
          
          And I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine

          Your grace abounds in deepest waters
          Your sovereign hand
          Will be my guide
          Where feet may fail and fear surrounds me
          You've never failed and You won't start now

          So I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine
          """)
        
        let song5 = Song(title: "Reckless Love",
        artist: "Cory Asbury",
        key: Key.D,
        tempo: "82",
        lyrics: """
          You call me out upon the waters
          The great unknown where feet may fail
          And there I find You in the mystery
          In oceans deep
          My faith will stand
          
          And I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine

          Your grace abounds in deepest waters
          Your sovereign hand
          Will be my guide
          Where feet may fail and fear surrounds me
          You've never failed and You won't start now

          So I will call upon Your name
          And keep my eyes above the waves
          When oceans rise
          My soul will rest in Your embrace
          For I am Yours and You are mine
          """)
        
        return [song1, song2, song3, song4, song5]
    }
}
