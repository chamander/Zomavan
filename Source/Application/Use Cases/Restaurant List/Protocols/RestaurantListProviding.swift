protocol ZomatoRestaurantListProviding {

    func withRestaurantList(forSubzoneID subzoneID: String, execute closure: @escaping (Result<[Restaurant], AnyError>) -> Void)
}
