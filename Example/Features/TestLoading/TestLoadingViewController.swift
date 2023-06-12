// 
import components
import UIKit

class TestLoadingViewController: LoadingViewController {
    override init(viewModel: LoadingViewModel) {
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
