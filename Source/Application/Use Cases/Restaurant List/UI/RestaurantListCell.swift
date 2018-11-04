import UIKit

final class RestaurantListCell: UITableViewCell {

    static let height: CGFloat = 300.0

    private let nameLabel: UILabel
    private let addressLabel: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        let nameLabel = UILabel()
        let addressLabel = UILabel()

        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: 18.0, weight: .medium))

        addressLabel.adjustsFontForContentSizeCategory = true
        addressLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: 14.0, weight: .regular))

        self.nameLabel = nameLabel
        self.addressLabel = addressLabel

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.prepareSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Loading via. a coder is not supported")
    }

    func update(with viewModel: RestaurantListCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.addressLabel.text = viewModel.address
    }

    private func prepareSubviews() {

        [nameLabel, addressLabel].forEach { view in
            self.contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0),
                self.addressLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),

                self.addressLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24.0),
                self.nameLabel.bottomAnchor.constraint(equalTo: self.addressLabel.topAnchor, constant: -8.0),

                self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0),
                self.addressLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            ]
        )
    }
}
