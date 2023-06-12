// 

import RxCocoa
import RxSwift
import core
import UIKit

open class LoadingViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel: LoadingViewModel
    let loadTrigger = PublishSubject<Void>()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public init(viewModel: LoadingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoadingViewController", bundle: Bundle(for: LoadingViewController.self))
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        bindViewModel()
        loadTrigger.onNext(())
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
}

private extension LoadingViewController {
    func bindViewModel() {
        let input = LoadingViewModel.Input(
            loadApi: loadTrigger.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.loading
            .drive()
            .disposed(by: disposeBag)
    }
}
