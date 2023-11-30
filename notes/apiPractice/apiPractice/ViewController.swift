//
//  ViewController.swift
//  apiPractice
//
//  Created by Paul Stewart on 11/30/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            do {
                let people = try await StarwarsPeopleController.getAllPeople().results
                for person in people {
                    print(person.name)
                }
            } catch {
                print(error)
            }
        }
    }
    

}

