import UIKit

protocol UseCaseCoordinator: class {

    associatedtype Dependencies
    init(dependencies: Dependencies)

    var viewController: UIViewController { get }
}
