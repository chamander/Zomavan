import UIKit

final class ZomavanController: UseCaseCoordinator {

    init(dependencies: HasRestaurantListProvider & HasImageProvider) {
        self.restaurantListController = RestaurantListUseCaseController(dependencies: dependencies)
    }

    var viewController: UIViewController {
        return restaurantListController.viewController // The only view in the application at the moment.
    }

    private let restaurantListController: RestaurantListUseCaseController
}
