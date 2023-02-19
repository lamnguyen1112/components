//

import CoreExtension
import RxCocoa
import RxSwift

open class LoadingViewModel: ViewModelType {
    public let navigator: LoadingNavigator
    let disposedBag = DisposeBag()

    public init(navigator: LoadingNavigator) {
        self.navigator = navigator
    }

    public func transform(input: Input) -> Output {
        let loading = input.loadApi
            .do(onNext: { [weak self] in
                self?.loadingAPI()
            })
            .asDriverOnErrorJustComplete()

        return Output(
            loading: loading
        )
    }
    
    open func loadingAPI() {
        fatalError("implement its")
    }
}

public extension LoadingViewModel {
    struct Input {
        let loadApi: Observable<Void>
    }

    struct Output {
        let loading: Driver<Void>
    }
}
