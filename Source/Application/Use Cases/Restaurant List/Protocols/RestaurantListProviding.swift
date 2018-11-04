protocol RestaurantListProviding {

    func withRestaurantList(execute closure: @escaping (Result<[Restaurant], AnyError>) -> Void)
}
