import Realm
import RealmSwift

struct RealmRestaurantListProvider: ZomatoRestaurantListProviding {

    private let provider: ZomatoRestaurantListProviding
    private let configuration: Realm.Configuration
    private var realm: Realm {
        return Realm(unsafelyConfigured: configuration)
    }

    init(underlyingProvider: ZomatoRestaurantListProviding, configuration: Realm.Configuration = .defaultConfiguration) {
        self.provider = underlyingProvider
        self.configuration = configuration
    }

    func withRestaurantList(forSubzoneID subzoneID: String, execute closure: @escaping (Result<[Restaurant], AnyError>) -> Void) {

        let listQueryResult = realm.restaurantListResults(forSubzoneID: subzoneID)

        if let list: Realm_RestaurantList = listQueryResult.first {
            let restaurants: [Restaurant] = self.applicationRestaurants(from: list)
            if !restaurants.isEmpty {
                closure(.success(restaurants))
            }
        }

        self.provider.withRestaurantList(forSubzoneID: subzoneID) { result in
            switch result {
            case let .success(restaurants):
                self.realm.updateRestaurantList(restaurants, forSubzoneID: subzoneID)
                closure(.success(restaurants))
            case let .failure(error):
                closure(.failure(AnyError(error)))
            }
        }
    }

    private func applicationRestaurants(from restaurantList: Realm_RestaurantList) -> [Restaurant] {
        return restaurantList.restaurants.compactMap { realmRestaurant in
            guard let imageURL = URL(string: realmRestaurant.imageURLString) else {
                return nil
            }
            return Restaurant(
                name: realmRestaurant.name,
                address: realmRestaurant.address,
                imageURL: imageURL)
        }
    }
}

private extension Realm {

    func restaurantListResults(forSubzoneID subzoneID: String) -> Results<Realm_RestaurantList> {
        return self.objects(Realm_RestaurantList.self).filter("subzoneID = %@", subzoneID)
    }

    func updateRestaurantList(_ list: [Restaurant], forSubzoneID subzoneID: String) {

        let newRealmRestaurantList = Realm_RestaurantList()
        let realmRestaurants = List<Realm_Restaurant>()
        let _realmRestaurants: [Realm_Restaurant] = list.map { restaurant in
            let realmRestaurant = Realm_Restaurant()
            realmRestaurant.name = restaurant.name
            realmRestaurant.address = restaurant.address
            realmRestaurant.imageURLString = restaurant.imageURL.absoluteString
            return realmRestaurant
        }

        realmRestaurants.append(objectsIn: _realmRestaurants)

        newRealmRestaurantList.subzoneID = subzoneID
        newRealmRestaurantList.restaurants.append(objectsIn: realmRestaurants)

        try? write {
            delete(restaurantListResults(forSubzoneID: subzoneID))
            add(newRealmRestaurantList)
        }
    }
}

class Realm_RestaurantList: Object {

    @objc dynamic var subzoneID: String = ""
    let restaurants: List<Realm_Restaurant> = List()
}

class Realm_Restaurant: Object {

    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var imageURLString: String = ""
}
