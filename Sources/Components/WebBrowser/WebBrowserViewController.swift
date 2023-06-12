import core
import PanModal
import RxSwift
import RxRelay
import WebKit

public typealias PanModelOptions = WebBrowserViewController.PanModelOptions
public typealias WebResource = WebBrowserViewController.WebResource
public typealias WebBrowserOptions = WebBrowserViewController.WebBrowserOptions

public class WebBrowserViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var areaWebView: UIView!
    @IBOutlet private var leftButton: UIButton!
    @IBOutlet private var rightButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var indicatorView: UIActivityIndicatorView!
    @IBOutlet private var bottomAreaWebViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public var resource = BehaviorRelay<WebResource?>(value: nil)
    private var options: WebBrowserOptions

    private var webView: WKWebView!
    private var isFirstLoading = true
    private var isShowBackButton = false
    private var rootUrlString = ""
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    public init(options: WebBrowserOptions) {
        self.options = options
        self.resource.accept(options.resource)
        super.init(nibName: Self.classIdentifier, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        return nil
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        setupUI()
        setupWebView()
        bindingViews()
    }
    
    func setupUI() {
        leftButton.setImage(SFAsset.icClose?.tint(with: .darkGray), for: .normal)
        rightButton.setImage(SFAsset.icDownload?.tint(with: .darkGray), for: .normal)
        
        titleLabel.text = options.title
        titleLabel.isHidden = options.title.isEmpty
        rightButton.isHidden = true
    }
    
    func bindingViews() {
        leftButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.isShowBackButton {
                self.backButtonTapped()
            } else {
                self.closeButtonTapped()
            }
        }).disposed(by: disposeBag)
        
        rightButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            guard case .pdfData(let data, _) = self.resource.value else {
                return
            }
            self.openSaveFilePanel(data: data)
        }).disposed(by: disposeBag)
                
        resource
            .subscribe(onNext: { [weak self] webResource in
                self?.loadWebView(webResource)
            })
            .disposed(by: disposeBag)
    }
    
    private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func backButtonTapped() {
        webView.goBack()
    }
    
    private func showIndicator() {
        indicatorView.startAnimating()
    }
    
    private func hideIndicator() {
        indicatorView.stopAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    private func setupWebView() {
        webView = WKWebView(frame: areaWebView.bounds)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        areaWebView.addSubview(webView)
        webView.setFillingWithCenterAlign(in: areaWebView)
        
        view.layoutIfNeeded()
        
        if case .maxHeightWithTopInset(let height) = options.panOptions.panModalHeight {
            bottomAreaWebViewConstraint.constant = height + UIDevice.safeAreaInsets.bottom
        }
    }
    
    private func loadWebView(_ resource: WebResource?) {
        guard let resource = resource else { return }
        
        switch resource {
        case .urlString(let urlString):
            guard let url = URL(string: urlString) else { return }
            webView.load(URLRequest(url: url))
        case .pdfData(let data, _):
            webView.load(data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: URL(string: "https://www.google.com.vn")!)
        }
    }
    
    private func saveDataToDocumentDirectory(data: Data) -> Single<URL> {
        guard let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last else {
            return .error(WebBrowserError.pathNotFound)
        }
        guard case .pdfData(_, let pdfFileName) = resource.value else {
            return .error(WebBrowserError.writeFileFail)
        }
        let pdfNameFromUrl = pdfFileName
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        do {
            try data.write(to: actualPath, options: .atomic)
            return .just(actualPath)
        } catch {
            return .error(WebBrowserError.writeFileFail)
        }
    }
    
    private func openSaveFilePanel(data: Data) {
        saveDataToDocumentDirectory(data: data)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] in
                let documentController = UIDocumentPickerViewController(url: $0, in: .exportToService)
                self?.present(documentController, animated: true)
            }, onFailure: { [weak self] in
                guard let fileError = $0 as? WebBrowserError else { return }
                let alert = UIAlertController(title: fileError.errorDescription, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: L10n.Common.Alert.ok, style: .default))
                self?.present(alert, animated: true)
            }).disposed(by: disposeBag)
    }
}

// MARK: - WKUIDelegate

extension WebBrowserViewController: WKUIDelegate, WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideIndicator()
        rightButton.isHidden = resource.value?.isHiddenRightButton ?? true
        
        if isFirstLoading {
            rootUrlString = webView.url?.absoluteString ?? ""
            isFirstLoading = false
            return
        }
            
        updateNavigate()
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showIndicator()
    }
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    private func updateNavigate() {
        if options.isShowNavigateWhenLoadWebView {
            if let urlString = webView.url?.absoluteString, urlString == rootUrlString {
                leftButton.setImage(SFAsset.icClose?.tint(with: .darkGray), for: .normal)
                isShowBackButton = false
            } else {
                leftButton.setImage(SFAsset.icArrowLeft?.tint(with: .darkGray), for: .normal)
                isShowBackButton = true
            }
        }
    }
}

// MARK: - PanModalPresentable

extension WebBrowserViewController: PanModalPresentable {
    public var panScrollable: UIScrollView? {
        return nil
    }
    
    public var topOffset: CGFloat {
        return 0.0
    }
    
    public var springDamping: CGFloat {
        return 1.0
    }
    
    public var transitionDuration: Double {
        return 0.4
    }
    
    public var shouldRoundTopCorners: Bool {
        return options.panOptions.cornerRadius != 0
    }
    
    public var transitionAnimationOptions: UIView.AnimationOptions {
        return [.allowUserInteraction, .beginFromCurrentState]
    }
    
    public var showDragIndicator: Bool {
        return false
    }
    
    public var longFormHeight: PanModalHeight {
        options.panOptions.panModalHeight
    }
    
    public var anchorModalToLongForm: Bool {
        return false
    }
    
    public var panModalBackgroundColor: UIColor {
        UIColor.black.withAlphaComponent(0.5)
    }
    
    public var cornerRadius: CGFloat {
        options.panOptions.cornerRadius
    }
}

public extension WebBrowserViewController {
    enum WebResource {
        case urlString(urlString: String)
        case pdfData(data: Data, fileName: String)
        
        var isHiddenRightButton: Bool {
            switch self {
            case .urlString(_):
                return true
            case .pdfData(_, _):
                return false
            }
        }
    }

    struct PanModelOptions {
        let cornerRadius: CGFloat
        let panModalHeight: PanModalHeight
        
        public init(cornerRadius: CGFloat = 16, panModalHeight: PanModalHeight = .maxHeightWithTopInset(68)) {
            self.cornerRadius = abs(cornerRadius)
            self.panModalHeight = panModalHeight
        }
    }
    
    enum WebBrowserError: Error {
        case pathNotFound
        case writeFileFail
        
        var errorDescription: String {
            switch self {
            case .pathNotFound:
                return L10n.Common.Error.notFoundPath
            case .writeFileFail:
                return L10n.Common.Error.writeFileError
            }
        }
    }
    
    struct WebBrowserOptions {
        var title: String = ""
        var resource: WebResource?
        var panOptions: PanModelOptions = .init()
        var isShowNavigateWhenLoadWebView: Bool = true
        
        public init(title: String = "", resource: WebResource? = nil, panOptions: PanModelOptions = .init(), isShowNavigateWhenLoadWebView: Bool = true) {
            self.title = title
            self.resource = resource
            self.panOptions = panOptions
            self.isShowNavigateWhenLoadWebView = isShowNavigateWhenLoadWebView
        }
    }
}
