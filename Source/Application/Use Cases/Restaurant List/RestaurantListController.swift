import UIKit

final class RestaurantListController: UseCaseCoordinator {

    let viewController: UIViewController

    init() {

        let listViewController = RestaurantListViewController()
        let navigationController = UINavigationController(rootViewController: listViewController)

        navigationController.navigationBar.prefersLargeTitles = true

        self.viewController = navigationController

        listViewController.update(with: RestaurantListViewModel())
    }
}
