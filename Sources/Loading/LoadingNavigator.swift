// 

import UIKit

public protocol LoadingNavigator {
    func navigateNext()
    func showError()
}

open class DefaultLoadingNavigator: LoadingNavigator {
    public let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    open func navigateNext() {
        print(#file, #function, #line)
    }
    
    open func showError() {
        print(#file, #function, #line)
    }
}

