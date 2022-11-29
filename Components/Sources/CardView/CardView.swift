//
//  CardView.swift
//  Components
//
//  Created by Lazyman on 11/29/22.
//

import CoreExtension
import SnapKit
import UIKit

public class CardView: UIView {
    lazy var circleView: UIView = {
        let view = UIView()
        view.borderColor = UIColor.blue
        view.borderWidth = 1.0
        view.backgroundColor = UIColor.cyan

        return view
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubView()
    }

    func setupSubView() {
        backgroundColor = .purple
        circleView.cornerRadius = bounds.width / 2
        addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}
