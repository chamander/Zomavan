struct RestaurantListCellViewModel {

    init(restaurant: Restaurant) {
        self.name = restaurant.name
        self.address = restaurant.address
    }

    let name: String
    let address: String
}
