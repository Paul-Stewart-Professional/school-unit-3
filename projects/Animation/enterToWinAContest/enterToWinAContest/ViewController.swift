//
//  ViewController.swift
//  enterToWinAContest
//
//  Created by Paul Stewart on 12/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if textField.text!.count == 9 {
            performSegue(withIdentifier: "sucessfulSegue", sender: UIButton.self)
        } else {
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: [.autoreverse],
                           animations: {
                self.textField.transform = CGAffineTransform(translationX: 10, y: 0)
            }) { (_) in
                self.textField.transform = CGAffineTransform.identity
                let feedbackGenerator = UINotificationFeedbackGenerator()
                feedbackGenerator.notificationOccurred(.error)
            }
        }
    }
    
}

