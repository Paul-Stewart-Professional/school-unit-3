//
//  RepResultsTableViewController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/4/23.
//

import UIKit

class RepResultsTableViewController: UITableViewController {
    var reps: [Representative] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reps.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as! RepsTableViewCell
        cell.delegate = self
        let currentRep = reps[indexPath.row]
        cell.partyStateLabel.text = "\(currentRep.party), \(currentRep.state)"
        cell.repNameLabel.text = currentRep.name
        cell.rep = currentRep
        cell.url = URL(string: currentRep.link)
        return cell
    }
}

extension RepResultsTableViewController: RepsTableViewCellDelegate {
    func grabURL(rep: Representative, url: URL) {
        if let url = URL(string: rep.link) {
            UIApplication.shared.open(url)
        }
    }
}

protocol RepsTableViewCellDelegate: AnyObject {
    func grabURL(rep: Representative, url: URL)
}
