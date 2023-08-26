//
//  ViewController.swift
//  QuizzerMizzer 3.0
//
//  Created by Pritesh Rajyaguru on 5/8/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startQuiz() {
        let vc = storyboard?.instantiateViewController(identifier: "game") as! QuizzerViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

