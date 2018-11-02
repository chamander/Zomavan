import UIKit

final class ZomavanController: UseCaseCoordinator {
    
    init() {
        self.viewController = ViewController()
    }
    
    let viewController: UIViewController
}
