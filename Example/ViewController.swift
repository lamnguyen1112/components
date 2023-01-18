//
//  ViewController.swift
//  Example
//
//  Created by Lazyman on 11/29/22.
//

import UIKit
import Components
import CoreExtension
import RxSwift

class ViewController: UIViewController {
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = L10n.Home.title
        view.backgroundColor = Colors.ca832a2.color
    }
    
    @IBAction func showLoading(_ sender: Any) {
//        testLoading()
//        showWebBrowser()
        showSkeletonList()
    }
    
    func testLoading() {
        let navigator = DefaultTestLoadingNavigator(navigationController: navigationController!)
        let viewModel = TestLoadingViewModel(navigator: navigator)
        let viewController = TestLoadingViewController(viewModel: viewModel)
//
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showWebBrowser() {
        let browserViewController = WebBrowserViewController(options: WebBrowserOptions(resource: .urlString(urlString: "https://www.google.com.vn")))
        navigationController?.presentPanModal(browserViewController)

//        loadFilePdf()
//            .bind(to: browserViewController.resource)
//            .disposed(by: disposedBag)
    }
    
    func showSkeletonView() {
        let skeletonVC = SkeletonViewController.instanceFromNibClass()
        navigationController?.pushViewController(skeletonVC, animated: true)
    }
    
    func showSkeletonList() {
        let skeletonListVC = SkeletonListViewController.instanceFromNibClass()
        navigationController?.pushViewController(skeletonListVC, animated: true)
    }
    
    typealias WebResource = WebBrowserViewController.WebResource
    typealias WebBrowerError = WebBrowserViewController.WebBrowserError
    
    func loadFilePdf() -> Observable<WebResource> {
        return Observable.create { observer in
            let url = Bundle.main.url(forResource: "examplePDF", withExtension: "pdf")
            print(url!)
            do {
                let data = try Data(contentsOf: url!)
                delay(seconds: 3) {
                    observer.onNext(WebResource.pdfData(data: data, fileName: "examplePDF"))
                    observer.onCompleted()
                }
            } catch {
                print("Unable to load data: \(error)")
                observer.onError(WebBrowerError.pathNotFound)
            }
            
            return Disposables.create()
        }
    }
}
