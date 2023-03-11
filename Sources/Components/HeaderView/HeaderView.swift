//
//  HeaderView.swift
//  Components
//
//  Created by Lazyman on 3/2/23.
//

import UIKit
import SkeletonView

public class HeaderView: BaseView {
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
        imageView.cornerRadius = 8.0
        imageView.contentMode = .scaleAspectFill
    }
    
    public func showSkeleton() {
        [imageView, titleLabel, descriptionLabel].forEach { view in
            view?.showAnimatedGradientSkeleton()
        }
    }
    
    public func hideSkeleton() {
        [imageView, titleLabel, descriptionLabel].forEach { view in
            view?.hideSkeleton()
        }
    }
}

public extension HeaderView {
    func setHeader(with image: UIImage? = nil, title: String? = nil, descript: String? = nil) {
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = descript
    }
}
