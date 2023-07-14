//
//  SkeletonViewController.swift
//  Example
//
//  Created by Lazyman on 1/18/23.
//

import UIKit
import SkeletonView
import Extensions

class SkeletonViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.linesCornerRadius = 4
            descriptionLabel.skeletonTextLineHeight = .fixed(15.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.showAnimatedGradientSkeleton()
        
        delay(seconds: 5.0, execute: { [weak self] in
            self?.view.hideSkeleton()
        })
    }
}
