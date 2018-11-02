import UIKit

final class ZomavanController: UseCaseCoordinator {

    var viewController: UIViewController {
        return restaurantListController.viewController // The only view in the application at the moment.
    }

    private let restaurantListController = RestaurantListController()
}
