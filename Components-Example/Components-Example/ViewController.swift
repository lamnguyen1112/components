//
//  ViewController.swift
//  Example
//
//  Created by Lazyman on 11/29/22.
//

import UIKit
import Extensions
import Components
import PanModal
import RxSwift

class ViewController: UIViewController {
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = L10n.Home.title
        view.backgroundColor = Colors.ca832a2.color
    }
    
    @IBAction func showLoading(_ sender: Any) {
        showSkeletonView()
    }
    
    func showSkeletonView() {
        let skeletonVC = SkeletonViewController.instanceFromNibClass()
        navigationController?.pushViewController(skeletonVC, animated: true)
    }
    
    func showSkeletonList() {
        let skeletonListVC = SkeletonListViewController.instanceFromNibClass()
        navigationController?.pushViewController(skeletonListVC, animated: true)
    }
}
