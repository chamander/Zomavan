import UIKit

final class RestaurantListController: NSObject {

    private static let listCellReuseIdentifier = "_restaurant_list_cell"
    private let dependencies: HasImageProvider

    private let restaurants: [Restaurant]

    private var images: [Restaurant: UIImage] = Dictionary()
    private var isLoadingImage: [Restaurant: Bool] = Dictionary()

    init(dependencies: HasImageProvider, restaurants: [Restaurant]) {
        self.dependencies = dependencies
        self.restaurants = restaurants
    }

    func prepare(tableView: UITableView) {
        tableView.register(RestaurantListCell.self, forCellReuseIdentifier: RestaurantListController.listCellReuseIdentifier)
    }
}

extension RestaurantListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListController.listCellReuseIdentifier, for: indexPath)
        if let cell = cell as? RestaurantListCell {

            let restaurant = self.restaurants[indexPath.row]

            cell.update(with: RestaurantListCellViewModel(restaurant: restaurant))

            if let image = self.images[restaurant] {
                cell.updateImage(image)
            } else {
                switch self.isLoadingImage[restaurant] {
                case true?:
                    break // Will update iamge inside the handler block below once loaded.
                case false?, nil:
                    self.isLoadingImage[restaurant] = true
                    self.dependencies.imageProvider.withImage(at: restaurant.imageURL) { [weak self, weak cell] result in
                        switch result {
                        case let .success(image):
                            self?.images[restaurant] = image
                            safelyOnMainThread {
                                cell?.updateImage(image)
                            }
                            self?.isLoadingImage[restaurant] = false
                        case .failure:
                            break
                        }
                    }
                }
            }
        }
        return cell
    }
}

extension RestaurantListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RestaurantListCell.height
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
