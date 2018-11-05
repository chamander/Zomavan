import Realm
import RealmSwift

struct FavouriteRestaurantListProvider: ZomatoRestaurantListProviding {

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

        self.provider.withRestaurantList(forSubzoneID: subzoneID) { result in
            switch result {
            case let .success(restaurants):
                let favouritesQueryResults = self.realm.favourites(forSubzoneID: subzoneID)
                if let realmFavourites = favouritesQueryResults.first {
                    let favouritedRestaurants = restaurants.filter { restaurant in
                        realmFavourites.favouriteRestaurantIdentifiers.contains(restaurant.identifier)
                    }
                    closure(.success(favouritedRestaurants))
                } else {
                    closure(.success([]))
                }
            case let .failure(error):
                closure(.failure(AnyError(error)))
            }
        }
    }
}

private extension Realm {

    func favourites(forSubzoneID subzoneID: String) -> Results<Realm_FavouritesList> {
        return self.objects(Realm_FavouritesList.self).filter("subzoneID = %@", subzoneID)
    }
}

class Realm_FavouritesList: Object {
    @objc dynamic var subzoneID: String = ""
    let favouriteRestaurantIdentifiers: List<String> = List()
}
