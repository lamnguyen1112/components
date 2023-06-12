// 

import components
import core

class TestLoadingViewModel: LoadingViewModel {
    override func loadingAPI() {
        print("test loading api")
        delay(seconds: 3, execute: { [weak self] in
            self?.navigator.navigateNext()
        })
    }
}
