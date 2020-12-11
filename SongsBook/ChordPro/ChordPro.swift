//
//  SongPro.swift
//  SongPro Editor
//
//  Created by Brian Kelly on 6/29/20.
//  Copyright © 2020 SongPro. All rights reserved.
//

import Foundation

public struct ChordPro {
    static let sectionRegex = try! NSRegularExpression(pattern: "#\\s*([^$]*)")
    static let attributeRegex = try! NSRegularExpression(pattern: "@(\\w*)=([^%]*)")
    static let customAttributeRegex = try! NSRegularExpression(pattern: "!(\\w*)=([^%]*)")
    static let chordsAndLyricsRegex = try! NSRegularExpression(pattern: "(\\[[\\w#b/]+])?([^\\[]*)", options: .caseInsensitive)

    static let measuresRegex = try! NSRegularExpression(pattern: "([\\[[\\w#b\\/]+\\]\\s]+)[|]*", options: .caseInsensitive)
    static let chordsRegex = try! NSRegularExpression(pattern: "\\[([\\w#b\\/]+)\\]?", options: .caseInsensitive)
    static let commentRegex = try! NSRegularExpression(pattern: ">\\s*([^$]*)")
    
    
//MARK: - PARSE & FORMAT
    
    static func formatSong(_ song: Song) -> String? {
        
        let newLine = "\n"
        let space = " "
        var text = ""
        
        
        // Проходим по каждой секции: INTRO, VERSE, CHORUS, etc...
        for sections in song.sections {
            // Вставляем название секции (VERSE) и ставим 2 переноса строки
            text.append(sections.name!.uppercased() + newLine + newLine)
            
            // Проходим по каждой отдельной строке
            for line in sections.lines {
                var chords = ""
                var words = ""
                for parts in line.parts {
                    
                    if !parts.isEmpty {
                        chords.append(parts.chord! + space)
                        words.append(parts.lyric!)
                    }
                }
                text.append(chords)
                text.append(newLine)
                text.append(words)
                //print("🧯 " + chords)
                
                for measure in line.measures {
                    for chord in measure.chords {
                        text.append(chord + space)
                    }
                }
                
                text.append(newLine)
            } // end for line in...
            
            text.append(newLine)
        } // end for sections in...
        
        return text
    }
    
    
    static func parse(_ lines: String) -> Song {
        var song = Song()
        var currentSection: Section?

        for text in lines.components(separatedBy: "\n") {
            if (text.starts(with: "@")) {
                processAttribute(text: text, song: &song)
            } else if (text.starts(with: "!")) {
                processCustomAttribute(text: text, song: &song)
            } else if (text.starts(with: "#")) {
                currentSection = processSection(text: text, song: &song)
            } else {
                processLyricsAndChords(text: text, song: &song, currentSection: &currentSection)
            }
        }

        return song
    }
    
    fileprivate static func processAttribute(text: String, song: inout Song) {
        var key: String?
        var value: String?

        if let match = attributeRegex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) {
            if let keyRange = Range(match.range(at: 1), in: text) {
                key = text[keyRange].trimmingCharacters(in: .whitespacesAndNewlines)
            }

            if let valueRange = Range(match.range(at: 2), in: text) {
                value = text[valueRange].trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        switch key {
        case "title":
            song.title = value!
        case "artist":
            song.artist = value!
//        case "capo":
//            song.capo = value!
        case "key":
            song.key = value!
        case "tempo":
            song.tempo = value!
        default:
            break
        }
    }
    
    fileprivate static func processCustomAttribute(text: String, song: inout Song) {
        var key: String?
        var value: String?

        if let match = customAttributeRegex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) {
            if let keyRange = Range(match.range(at: 1), in: text) {
                key = text[keyRange].trimmingCharacters(in: .whitespacesAndNewlines)
            }

            if let valueRange = Range(match.range(at: 2), in: text) {
                value = text[valueRange].trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        if (key != nil && value != nil) {
            //song.custom.updateValue(value!, forKey: key!)
        }
    }
    
    
    fileprivate static func processSection(text: String, song: inout Song) -> Section {
        var key: String?
        let section = Section()

        if let match = sectionRegex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) {
            if let keyRange = Range(match.range(at: 1), in: text) {
                key = text[keyRange].trimmingCharacters(in: .whitespacesAndNewlines)
                section.name = key!
            }
        }

       song.sections.append(section)

        return section;
    }

    
    fileprivate static func processLyricsAndChords(text: String, song: inout Song, currentSection: inout Section?) {
        if text.isEmpty {
            return
        }

        if currentSection == nil {
            currentSection = Section()
            song.sections.append(currentSection!)
        }

        let line = Line()
        
        if text.starts(with: "|-") {
            line.tablature = text
        } else if text.starts(with: "| ") {
            let measureMatches = measuresRegex.matches(in: text, range: NSRange(location: 0, length: text.utf16.count))

            var measures = [Measure]()
            
            for match in measureMatches {
                if let measureRange = Range(match.range(at: 1), in: text) {
                    let measureText = text[measureRange].trimmingCharacters(in: .whitespacesAndNewlines)
                    let chordsMatches = chordsRegex.matches(in: measureText, range: NSRange(location: 0, length: measureText.utf16.count))
                    
                    let measure = Measure()
                    measure.chords = chordsMatches.map {
                        if let chordsRange = Range($0.range(at: 1), in: measureText) {
                            return String(measureText[chordsRange].trimmingCharacters(in: .whitespacesAndNewlines))
                        }
                        
                        return ""
                    }
                    measures.append(measure)
                }
            }
            
            line.measures = measures
        } else if text.starts(with: ">") {

            if let match = commentRegex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) {
                if let commentRange = Range(match.range(at: 1), in: text) {
                    line.comment = text[commentRange].trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
        } else {
            let matches = chordsAndLyricsRegex.matches(in: text, range: NSRange(location: 0, length: text.utf16.count))

            for match in matches {
                let part = Part()

                if let keyRange = Range(match.range(at: 1), in: text) {
                    part.chord = text[keyRange]
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .replacingOccurrences(of: "[", with: "")
                            .replacingOccurrences(of: "]", with: "")
                } else {
                    part.chord = ""
                }

                if let valueRange = Range(match.range(at: 2), in: text) {
                    part.lyric = String(text[valueRange])
                } else {
                    part.lyric = ""
                }

                if !(part.isEmpty) {
                    line.parts.append(part)
                }
            }
        }

        currentSection!.lines.append(line)
    }
}
