import UIKit

final class RestaurantListUseCaseController: UseCaseCoordinator {

    private let dependencies: Dependencies
    private let listViewController: RestaurantListViewController

    private var listContentController: RestaurantListController?

    init(dependencies: HasRestaurantListProvider & HasImageProvider) {

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
        self.dependencies.restaurantListProvider.withRestaurantList { [dependencies] result in
            switch result {
            case let .success(restaurants):
                let listContentController = RestaurantListController(dependencies: dependencies, restaurants: restaurants)
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
