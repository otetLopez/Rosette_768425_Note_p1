//
//  CategoryTableViewController.swift
//  Rosette_768425_Note_p1
//
//  Created by otet_tud on 11/7/19.
//  Copyright © 2019 otet_tud. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    var folderList = [Folder]()
    var folderIdx : Int = -1
    var isEditingFolders : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.editButtonItem.tintColor = UIColor.white
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return folderList.count
    }
    
    @IBAction func nFolderButtonPressed(_ sender: UIBarButtonItem) {
        alert()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folder cell", for: indexPath)
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "folder cell")
        cell.textLabel?.text = folderList[indexPath.row].getfname()
        cell.imageView?.image = UIImage(named: "folder-icon")
        cell.detailTextLabel?.text = ("\(folderList[indexPath.row].getNotesNum())")
        cell.detailTextLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func isNameValid(fname: String) -> Bool {
        for index in folderList {
            if index.getfname() == fname {
                alert(msg: "Name Taken")
                return false
            }
        }
        return true
    }
    
    func alert(msg : String) {
        let alertController = UIAlertController(title: msg, message: "Please choose a different name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        okAction.setValue(UIColor.orange, forKey: "titleTextColor")
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alert() {
        let alertController = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
            
        var nFolderName : UITextField?
        alertController.addTextField { (nFolderName) in
            nFolderName.placeholder = "example New Folder"
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
        
        let addItemAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let textField = alertController.textFields![0]
            print("DEBUG: Will be adding folder \(textField.text!)")
            if(self.isNameValid(fname: "\(textField.text!)")) {
                self.addNewFolder(fname: "\(textField.text!)")
                self.reloadTableView()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addItemAction)
            
        self.present(alertController, animated: true, completion: nil)
    }

    func addNewFolder(fname: String) {
        let nFolder : Folder = Folder(fname: fname)
        folderList.append(nFolder)
    }

    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        if isEditingFolders == true {
            self.tableView.isEditing = false
            isEditingFolders = false
            sender.title = "Edit"
        } else {
            print("DEBUG: Now Editing Folders")
            self.tableView.isEditing = true
            sender.title = "Done"
            isEditingFolders = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
           tableView.reloadData()
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        folderIdx = indexPath.row
        self.tableView.cellForRow(at: indexPath)?.accessoryView?.backgroundColor = UIColor.systemGray
        self.tableView.cellForRow(at: indexPath)?.isHighlighted = false
        self.tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        print("You selected Folder \(folderList[indexPath.row].getfname()) at \(folderIdx)")
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if (tableView.isEditing == true) {
            print("DEBUG: Trying to delete while in edit mode") }

        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
        self.folderList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)})

        return UISwipeActionsConfiguration(actions: [DeleteAction])
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.folderList[sourceIndexPath.row]
        folderList.remove(at: sourceIndexPath.row)
        folderList.insert(movedObject, at: destinationIndexPath.row)
    }
    
        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .none
        }
        override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return false
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
        
        if let notes = segue.destination as? NotesTableViewController {
            notes.delegate = self
        }
    }
    

}
