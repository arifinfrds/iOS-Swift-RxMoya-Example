//
//  ViewController.swift
//  RxMoyaExample
//
//  Created by Arifin Firdaus on 26/01/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    private func setupInitialState() {
        titleLabel.text = ""
    }

}

