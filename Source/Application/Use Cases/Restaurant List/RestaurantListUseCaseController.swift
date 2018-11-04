import UIKit

final class RestaurantListUseCaseController: UseCaseCoordinator {

    private let dependencies: Dependencies
    private let listViewController: RestaurantListViewController

    private var listContentController: RestaurantListController?

    init(dependencies: HasRestaurantListProvider) {

        self.dependencies = dependencies

        let listViewController = RestaurantListViewController()
        let navigationController = UINavigationController(rootViewController: listViewController)

        navigationController.navigationBar.prefersLargeTitles = true

        self.listViewController = listViewController
        self.viewController = navigationController

        listViewController.update(with: RestaurantListViewModel())
        fetchData()
    }

    private func fetchData() {
        self.dependencies.restaurantListProvider.withRestaurantList { result in
            switch result {
            case let .success(restaurants):
                let listContentController = RestaurantListController(restaurants: restaurants)
                self.listContentController = listContentController
                safelyOnMainThread {
                    self.listViewController.updateList(with: listContentController)
                }
            case .failure:
                break
            }
        }
    }

    let viewController: UIViewController
}
