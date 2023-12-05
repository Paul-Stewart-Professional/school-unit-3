//
//  ViewController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/1/23.
//

import UIKit

class RepViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            do {
                let rep = try await APIRequestsController.fetchRep(zip: "84043").results
                for person in rep {
                    print(person.name)
                }
            } catch {
                print(error)
            }
        }
    }


}

