//
//  ViewController.swift
//  Example
//
//  Created by Lazyman on 11/29/22.
//

import UIKit
import Components

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let cardView = CardView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        view.addSubview(cardView)
    }
}
