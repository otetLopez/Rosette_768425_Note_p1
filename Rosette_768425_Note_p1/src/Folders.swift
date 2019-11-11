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
    //private var note : [String]
    
    init() {
        fname = ""
        notesNum = 0
    }
    init(fname: String) {
        self.fname = fname
        self.notesNum = 0
        print("DEBUG: Added folder \(fname)")
    }
    
    func addNotes(newNote: String) {
        
    }
    
    func getfname() -> String {
        return self.fname
    }
    
    func getNotesNum() -> Int {
        return self.notesNum
    }
    
    var description: String {
        return "Folder name: \(self.fname)"
    }
}
