
import UIKit

class BaseNavigationController: UINavigationController {

    // MARK: - Private properties -
    private var duringPushAnimation = false
    
    // MARK: - Public properties -
    var statusBarStyle: UIStatusBarStyle = .default
    var interactivePopIsEnabled: Bool = true
    
    // MARK: - Lifecycle -
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(rootWireframe: BaseWireframe, presentationControllerDelegate: UIAdaptivePresentationControllerDelegate? = nil) {
        self.init()
        viewControllers = [rootWireframe.viewController]
        if let presentationControllerDelegate = presentationControllerDelegate { presentationController?.delegate = presentationControllerDelegate }
    }
    
    override convenience init(rootViewController: UIViewController) {
        self.init()
        viewControllers = [rootViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        navigationBar.tintColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Public methods -
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}

// MARK: - Extensions -
extension BaseNavigationController {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        (navigationController as? BaseNavigationController)?.duringPushAnimation = false
    }
    
    func setPresentationControllerDelegate(_ presentationControllerDelegate: UIAdaptivePresentationControllerDelegate?) {
        presentationController?.delegate = presentationControllerDelegate
    }
}

