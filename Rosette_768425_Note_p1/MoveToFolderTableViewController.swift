//
//  MoveToFolderTableViewController.swift
//  Rosette_768425_Note_p1
//
//  Created by otet_tud on 11/12/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class MoveToFolderTableViewController: UITableViewController {

    weak var delegateMoveNote: NotesTableViewController?
    var folderList = [Folder]()
    var folderIdx : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = backButton
        
        self.folderList = (self.delegateMoveNote?.getFolderList())!
    }

    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        print("DEBUG: Cancelling move action")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func back() {
    self.dismiss(animated: true, completion: nil) }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("DEBUG: There are \(self.folderList.count) Available folders")
        return self.folderList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folder list", for: indexPath)
        cell.textLabel?.text = self.folderList[indexPath.row].getfname()

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        folderIdx = indexPath.row
        print("You selected destination \(folderList[indexPath.row]) at \(folderIdx)")
        alert()
    }
    
    func moveNote() {
        self.delegateMoveNote?.addNote(folderIndex: folderIdx)
        self.delegateMoveNote?.deleteNote()
        self.delegateMoveNote?.tableViewRefresh()
    }
    
    func alert() {
        let alertController = UIAlertController(title: "Move to \(folderList[folderIdx].getfname())", message: "Are you sure?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            //Dismiss alert
        }
        cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
        
        let deleteAction = UIAlertAction(title: "Move", style: .destructive) { (action) in
                self.moveNote()
                self.dismiss(animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
