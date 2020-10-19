//
//  SongCell.swift
//  TableViewTest
//
//  Created by Daniel Yamrak on 22.09.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var byAuthor: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var keyValue: UILabel!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var tempoValue: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    
    
    func set(song: Song) {
        songTitle.text = song.title
        byAuthor.text = "by " + song.artist
        keyValue.text = song.key
        tempoValue.text = song.tempo
    }
}
