import UIKit

final class RestaurantListViewController: UITableViewController {

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }

    func update(with viewModel: RestaurantListViewModel) {
        self.title = viewModel.title
    }

    func updateList(with controller: RestaurantListController) {
        self.tableView.dataSource = controller
        self.tableView.delegate = controller
        controller.prepare(tableView: self.tableView)
        self.tableView.reloadData()
    }
}
