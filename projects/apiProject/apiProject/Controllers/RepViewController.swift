//
//  ViewController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/1/23.
//

import UIKit

class RepViewController: UIViewController {
    
    @IBOutlet weak var findMyRepButton: UIButton!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    let controller = RepController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func findMyRepButtonTapped(_ sender: Any) {
        let zip = zipCodeTextField.text
        fetchReps(zip: zip ?? "error")
    }
    
    func fetchReps(zip: String) {
        Task {
            do {
                let reps = try await controller.fetchReps(zip: zip)
                await MainActor.run {
                    self.showResults(reps: reps)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func showResults(reps: [Representative]) {
        performSegue(withIdentifier: "repSegue", sender: reps)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repSegue" {
            guard let vc = segue.destination as? RepResultsTableViewController, let reps = sender as? [Representative] else { return }
            vc.reps = reps
        }
    }
}

