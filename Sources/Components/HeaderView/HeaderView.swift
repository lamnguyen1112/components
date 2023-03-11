//
//  HeaderView.swift
//  Components
//
//  Created by Lazyman on 3/2/23.
//

import UIKit
import SkeletonView

class HeaderView: BaseView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
        
    required init?(coder :NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .yellow
        imageView.backgroundColor = .lightGray
    }
    
    func showSkeleton() {
        [imageView, titleLabel, descriptionLabel].forEach { view in
            view?.showAnimatedGradientSkeleton()
        }
    }
    
    func hideSkeleton() {
        [imageView, titleLabel, descriptionLabel].forEach { view in
            view?.hideSkeleton()
        }
    }
}
