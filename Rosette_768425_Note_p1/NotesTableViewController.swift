//
//  NotesTableViewController.swift
//  Rosette_768425_Note_p1
//
//  Created by otet_tud on 11/11/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    weak var delegate: CategoryTableViewController?
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIBarButtonItem!
    
    var currFolder : Folder?
    var fidx : Int = -1
    var notesList = [String]()
    var noteIdx : Int = -1
    var noteToMoveIdx : Int = -1
    var noteIdxPath : IndexPath?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RCL: Initialize the current folder we are focusing on
        getFolderData()
        disableButtons()
        noteToMoveIdx = -1
        
        print("DEBUG: Entering List for  folder \(self.delegate!.folderList[fidx].getfname()) at \(self.delegate!.folderIdx)")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewDidAppear(_ animated: Bool) {
        noteToMoveIdx = -1
        tableViewRefresh()
        
        print("DEBUG viewDidAppear: Tasks are \(notesList.count) with list.count")
        print(notesList)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = notesList[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableViewRefresh() {
        notesList.removeAll()
        getFolderData()
        disableButtons()
        tableView.reloadData()
    }
    
    func getFolderData() {
        fidx = self.delegate!.folderIdx
        currFolder = self.delegate?.folderList[fidx]
        notesList = (currFolder?.getNoteList())!
    }
    
    func disableButtons() {
        moveButton.isEnabled = false
        moveButton.tintColor = UIColor.opaqueSeparator
        trashButton.isEnabled = false
        trashButton.tintColor = UIColor.opaqueSeparator
    }
    
    func enableButtons() {
        moveButton.isEnabled = true
        moveButton.tintColor = UIColor.white
        trashButton.isEnabled = true
        trashButton.tintColor = UIColor.white
    }

    func addNote(note : String) {
        print("DEBUG: Adding note \(note) to \(self.delegate?.folderList[fidx].getfname() ?? "no name")")
        self.delegate?.folderList[fidx].addNote(newNote: note)
    }
    
    func addNote(folderIndex : Int) {
        print("DEBUG: Adding note \(notesList[noteToMoveIdx]) to \(self.delegate?.folderList[folderIndex].getfname() ?? "no name")")
        self.delegate?.folderList[folderIndex].addNote(newNote: notesList[noteToMoveIdx])
    }

    
    func editNote(note : String, nidx : Int) {
        self.delegate?.folderList[fidx].editNote(note: note, index: nidx)
    }
    
    func deleteNote() {
        self.delegate?.folderList[fidx].deleteNote(idx: noteToMoveIdx)
    }
    
    func cancelledAction() {
        self.tableView.cellForRow(at: noteIdxPath!)?.isEditing = false
        disableButtons()
    }
    
    func getFolderList() -> [Folder] {
        return self.delegate!.folderList
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteToMoveIdx = indexPath.row
        noteIdxPath = indexPath
        enableButtons()
        if self.tableView.cellForRow(at: indexPath)?.isEditing == true {
            cancelledAction()
        } else {
            self.tableView.cellForRow(at: indexPath)?.isEditing = true
        }
        self.tableView.cellForRow(at: indexPath)?.accessoryView?.backgroundColor = UIColor.systemGray
        self.tableView.cellForRow(at: indexPath)?.isHighlighted = false
        self.tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        print("You selected Note \(notesList[indexPath.row]) at \(noteToMoveIdx)")
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("DEBUG: willDisplay at \(indexPath.row)")
        if indexPath.row == noteToMoveIdx {
            cell.backgroundColor = UIColor.systemGray;
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        noteIdx = indexPath.row
        print("You selected to edit Note \(notesList[indexPath.row]) at \(noteIdx)")    }
    
    @IBAction func addNoteButtonPressed(_ sender: UIBarButtonItem) {
        print("DEBUG: Add New Note Button Pressed")
        noteIdx = -1
    }
    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        alert()
    }
    @IBAction func moveButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func alert() {
        let alertController = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.cancelledAction()
        }
        cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.deleteNote()
                self.tableViewRefresh()
        }
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let note = segue.destination as? NotesViewController {
            note.delegateNotes = self
        }
        if let move = segue.destination as? MoveToFolderTableViewController {
            move.delegateMoveNote = self
        }
    }
    

}
