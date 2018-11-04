import UIKit

final class RestaurantListViewController: UITableViewController {

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }

    func update(with viewModel: RestaurantListViewModel) {
        self.title = viewModel.title
    }
}
