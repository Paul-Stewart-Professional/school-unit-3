//
//  ListOfListsTableViewController.swift
//  ToDoist
//
//  Created by Paul Stewart on 12/14/23.
//

import UIKit

class ListOfListsTableViewController: UITableViewController {
    
    var list: ToDoList?
    
    private let manager = ItemManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func showTextFieldAlert() {
            let alertController = UIAlertController(title: "Enter Text", message: "Please name your to do list:", preferredStyle: .alert)

            // Add a text field to the alert controller
            alertController.addTextField { (textField) in
                textField.placeholder = "enter a name"
            }

            // Add a cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            // Add an OK action with a handler
        let saveAction = UIAlertAction(title: "Save", style: .default) { [self, weak alertController] (_) in
                // Access the text field and do something with the entered text
                if let textField = alertController?.textFields?.first {
                    let enteredText = textField.text ?? ""
                    
                    print("Entered text: \(textField.text ?? "")")
                    // Perform any action with the entered text
                    manager.createNewToDoList(with: enteredText)
                    //make sure data is being saved by reading it
                    tableView.reloadData()
                }
            }
            alertController.addAction(saveAction)

            // Present the alert controller
            present(alertController, animated: true, completion: nil)
        }
    
    func list(at indexPath: IndexPath) -> ToDoList {
        manager.allLists()[indexPath.row]
    }
    
    
    @IBAction func addToDoButtonTapped(_ sender: Any) {
        showTextFieldAlert()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return manager.allLists().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        let thisParticularToDoList = list(at: indexPath)
        cell.textLabel?.text = thisParticularToDoList.title
        cell.detailTextLabel?.text = "\(thisParticularToDoList.itemsArray.count) items"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let thisParticularToDoList = list(at: indexPath)
        manager.remove(thisParticularToDoList.itemsArray[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: - Navigation

    
    @IBSegueAction func showItems(_ coder: NSCoder) -> ItemsViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedList = list(at: indexPath)
        return ItemsViewController(code: coder, list: selectedList)
    }
}

    
