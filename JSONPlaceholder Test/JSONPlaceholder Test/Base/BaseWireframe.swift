


import UIKit

protocol WireframeInterface: AnyObject { }


class BaseWireframe {

    unowned var _viewController: UIViewController
    
    // to retain view controller reference upon first access
    var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension BaseWireframe: WireframeInterface {
}

extension BaseWireframe {
    
    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }
    
    
    var navigationController: UINavigationController? {
        return _viewController.navigationController
    }
}

extension UIViewController {
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}
