//
//  HeaderView.swift
//  Components
//
//  Created by Lazyman on 3/2/23.
//

import UIKit
import SnapKit
import SkeletonView

public class HeaderView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Colors.ca832a2.color
        imageView.cornerRadius = 8.0
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.addSubview(imageView)
        return containerView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello world"
        label.textAlignment = .center

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello world"
        label.textAlignment = .center

        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [containerView, titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 10.0

        return stack
    }()

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
        addSubview(stackView)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalTo(100.0)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview()
        }
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
//    func setHeader(with image: UIImage? = nil, title: String? = nil, descript: String? = nil) {
//        imageView.image = image
//        titleLabel.text = title
//        descriptionLabel.text = descript
//    }
}

#if DEBUG
import SwiftUI
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let headerView = HeaderView()
            return headerView
        }
//        UIViewControllerPreview {
//            // Return whatever controller you want to preview
//            let vc = MyViewControllerToTest()
//            return vc
//        }
    }
}
#endif
