//
//  Folders.swift
//  Rosette_768425_Note_p1
//
//  Created by otet_tud on 11/7/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import Foundation

class Folder : CustomStringConvertible {
    private var fname : String
    private var notesNum : Int
    private var notesList : [String]
    
    init() {
        fname = ""
        notesNum = 0
        notesList = []
    }
    init(fname: String) {
        self.fname = fname
        self.notesNum = 0
        notesList = []
        print("DEBUG: Added folder \(fname)")
    }
    
    func addNote(newNote: String) {
        notesList.append(newNote)
        notesNum += 1
    }
    
    func editNote(note: String, index: Int) {
        notesList.remove(at: index)
        notesList.insert(note, at: index)
    }
    
    func deleteNote(idx: Int) {
        notesList.remove(at: idx)
        notesNum -= 1
    }
    
    func deleteNote(note : String) {
        var count : Int = 0
        for index in notesList {
            if index == note {
                notesList.remove(at: count)
                notesNum -= 1
            }
            count += 1
        }
    }
    
    func getfname() -> String {
        return self.fname
    }
    
    func getNotesNum() -> Int {
        return self.notesNum
    }
    
    func getNoteList() -> [String] {
        return self.notesList
    }
    
    var description: String {
        return "Folder name: \(self.fname)"
    }
}
