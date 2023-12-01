//
//  DogViewController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/1/23.
//

import UIKit

class DogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            do {
                let imageURL = try await apiRequestsController.fetchDog(numberOfDogs: 1).message
                print(imageURL)
            } catch {
                print(error)
            }
        }
    }
    
}
