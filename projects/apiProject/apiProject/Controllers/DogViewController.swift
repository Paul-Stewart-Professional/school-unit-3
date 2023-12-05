//
//  DogViewController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/1/23.
//

import UIKit

class DogViewController: UIViewController {
    
    @IBOutlet weak var generateButton: UIButton!
    
    @IBOutlet weak var numberOfDogsTextField: UITextField!
    
    let controller = DogController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if numberOfDogsTextField.text?.isEmpty == true {
            generateButton.isEnabled = false
        }
    }
    
    
    
    
    @IBAction func generateButtonTapped(_ sender: Any) {
        let count = Int(numberOfDogsTextField.text!) ?? 1
        fetchDogs(count: count)
    }
    
    func fetchDogs(count: Int) {
        Task {
            do {
                let urls = try await controller.fetchDogs(count: count)
                await MainActor.run {
                    self.showResults()
                }
                // trigger segue
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func showResults() {
        performSegue(withIdentifier: "dogImageSegue", sender: generateButton)
    }
    
}
