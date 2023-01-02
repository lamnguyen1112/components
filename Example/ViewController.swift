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
        title = L10n.Home.title
        view.backgroundColor = Colors.ca832a2.color
    }
    
    @IBAction func showLoading(_ sender: Any) {
        testLoading()
    }
    
    func testLoading() {
        let navigator = DefaultTestLoadingNavigator(navigationController: navigationController!)
        let viewModel = TestLoadingViewModel(navigator: navigator)
        let viewController = TestLoadingViewController(viewModel: viewModel)
//
        navigationController?.pushViewController(viewController, animated: true)
    }
}
