//
//  ViewController.swift
//  PokemonTestingDemo
//
//  Created by Ryan Plitt on 11/28/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let pokemonController = PokemonController()
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonLabel.text = ""
    }


    @IBAction func goButtonTapped(_ sender: Any) {
        numberTextField.resignFirstResponder()
        guard let id = Int(numberTextField.text!) else {
            return print("There was an error getting a number")
        }
        pokemonLabel.text = ""
        pokemonImageView.image = nil
        activityIndicator.startAnimating()
        // Fetch Pokemon Here
        Task {
            do {
                let pokemon = try await
                pokemonController.fetchPokemon(with: numberTextField.text!)
                pokemonLabel.text = pokemon.name.capitalized
                let imageData = try await pokemonController.fetchImageData(for: pokemon.imageURL)
                pokemonImageView.image = UIImage(data: imageData)
                activityIndicator.stopAnimating()
            } catch {
                print(error.localizedDescription)
                pokemonLabel.text = "There was an error. Try again."
                activityIndicator.stopAnimating()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goButtonTapped(self)
        return true
    }
}

