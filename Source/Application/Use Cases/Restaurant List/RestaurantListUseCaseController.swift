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
        let abbotsfordSubzoneID = "98284"
        self.dependencies.restaurantListProvider.withRestaurantList(forSubzoneID: abbotsfordSubzoneID) { [dependencies] result in
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
