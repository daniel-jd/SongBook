//
//  Line.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

public struct Line {
    public var parts = [Part]()
    public var measures = [Measure]()
    public var tablature: String?
    public var comment: String?
}
