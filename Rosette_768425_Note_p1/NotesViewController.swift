//
//  NotesViewController.swift
//  Rosette_768425_Note_p1
//
//  Created by otet_tud on 11/11/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var textViewOutlet: UITextView!
    weak var delegateNotes: NotesTableViewController?
    
    //RCL: This will indicate if we are adding a new note or modifying an existing one
    var mod : Bool = false
    //RCL: This is the index in the notesList of the specific note to edit
    var index : Int = -1
    //RCL: This is the index in the folderList the specific note belong to
    var fdx: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        index = self.delegateNotes!.noteIdx
        if index > -1 {
            textViewOutlet.text = self.delegateNotes?.notesList[index]
            mod = true }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !(textViewOutlet.text!.isEmpty) {
            if mod == true {
                self.delegateNotes?.editNote(note: self.textViewOutlet.text!, nidx: self.index)
                self.delegateNotes?.noteIdx = -1
                mod = false
            } else {
                self.delegateNotes?.addNote(note: textViewOutlet.text!)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
