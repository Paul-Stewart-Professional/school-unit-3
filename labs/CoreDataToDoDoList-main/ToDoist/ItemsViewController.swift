//
//  ViewController.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/15/22.
//

import UIKit

class ItemsViewController: UIViewController {
    
    enum TableSection: Int, CaseIterable {
        case incomplete, complete
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Properties
    
    let list: ToDoList
    
    private let itemManager = ItemManager.shared
    var incompleteItems: [Item] = []
    var completeItems: [Item] = []

    
    // MARK: - Lifecycle

    
    init?(code aDecoder: NSCoder, list: ToDoList) {
        self.list = list
        super.init(coder: aDecoder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
    }

}

// MARK: - Initialization


// MARK: - Private

private extension ItemsViewController {
    
    func item(at indexPath: IndexPath) -> Item {
        let tableSection = TableSection(rawValue: indexPath.section)!
        switch tableSection {
        case .incomplete:
            return incompleteItems[indexPath.row]
        case .complete:
            return completeItems[indexPath.row]
        }
    }
    
    func refreshData() {
        self.incompleteItems = itemManager.fetchIncompleteItems()
        self.completeItems = itemManager.fetchCompleteItems()
        tableView.reloadData()
    }
    
}


// MARK: - TableView DataSource

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return "To-Do (\(incompleteItems.count))"
        case .complete:
            return "Completed (\(completeItems.count))"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableSection = TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return incompleteItems.count
        case .complete:
            return completeItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
        let item = item(at: indexPath)
        cell.update(with: item)
        return cell
    }

    
    // Swipe to Delete
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let itemToRemove = item(at: indexPath)
        itemManager.remove(itemToRemove)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
        refreshData()
    }
    
}

// MARK: - TableView Delegate

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = item(at: indexPath)
        itemManager.toggleItemCompletion(item)
        refreshData()
    }
}


// MARK: - TextField Delegate

extension ItemsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return true }
        itemManager.createNewItem(with: text, toDoList: list)
        textField.text = ""
        refreshData()
        return true
    }
    
}
