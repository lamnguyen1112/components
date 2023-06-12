//
//  SkeletonListViewController.swift
//  Example
//
//  Created by Lazyman on 1/19/23.
//

import UIKit
import core
import SkeletonView

class SkeletonListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            ItemCell.registerNib(to: tableView)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.dataSource = self
            tableView.isSkeletonable = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.showAnimatedGradientSkeleton()
        
        delay(seconds: 3) { [weak self] in
            self?.view.hideSkeleton()
        }
    }
}

extension SkeletonListViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ItemCell.reuseIdentifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier) as! ItemCell
        
        return cell
    }
}
