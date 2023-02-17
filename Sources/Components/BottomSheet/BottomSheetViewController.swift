//
//  BottomSheetViewController.swift
//  Components
//
//  Created by Lazyman on 2/17/23.
//

import UIKit
import PanModal

public class BottomSheetViewController: UIViewController {
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: BottomSheetViewController.classIdentifier, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("deinit", Self.classIdentifier)
    }
}

extension BottomSheetViewController: PanModalPresentable {
    public var panScrollable: UIScrollView? {
        return nil
    }
    
    public var longFormHeight: PanModalHeight {
        .contentHeight(300)
    }
    
    public var showDragIndicator: Bool {
        return false
    }
}
