//
//  DogResultsTableViewController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/2/23.
//

import UIKit

class DogResultsTableViewController: UITableViewController {
    
    let controller = DogController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.imageURLs.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogImageCell", for: indexPath) as! DogImageTableViewCell
        
        let dogImageURL = controller.imageURLs[indexPath.row]
        cell.update(with: dogImageURL)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
}
