// 

import UIKit
import components
import core

final class DefaultTestLoadingNavigator: DefaultLoadingNavigator {
//    override func showError() {
//        print("show error")
//    }
//    
    override func navigateNext() {
        print("navigate next")
        let helloVC = HelloWorldViewController.instanceFromNibClass()
        navigationController.pushViewController(helloVC, animated: true)
    }
}
