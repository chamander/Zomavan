import UIKit

final class RestaurantListController: NSObject {

    private static let listCellReuseIdentifier = "_restaurant_list_cell"
    private let restaurants: [Restaurant]

    init(restaurants: [Restaurant]) {
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
            cell.update(with: RestaurantListCellViewModel(restaurant: self.restaurants[indexPath.row]))
        }
        return cell
    }
}

extension RestaurantListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RestaurantListCell.height
    }
}
