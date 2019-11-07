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
    
    init() {
        fname = ""
    }
    init(fname: String) {
        self.fname = fname
        print("DEBUG: Added folder \(fname)")
    }
    
    func getfname() -> String {
        return self.fname
    }
    
    var description: String {
        return "Folder name: \(self.fname)"
    }
}
