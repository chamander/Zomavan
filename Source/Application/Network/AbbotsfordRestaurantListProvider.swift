import Foundation

struct AbbotsfordRestaurantListProvider: RestaurantListProviding, EndpointClient {

    static let baseURLString: String = "https://developers.zomato.com/api/v2.1/"

    static let queryItems: [URLQueryItem] = [
        URLQueryItem(name: "entity_id", value: "98284"),
        URLQueryItem(name: "entity_type", value: "subzone"),
        URLQueryItem(name: "count", value: "10"),
    ]

    static let headerItems: [URLHeaderItem] = [
        URLHeaderItem(field: "user-key", value: "95ab57dfb9c5ebe2bab89c4af8a58062"),
    ]

    private let requestServicing: RequestServicing

    init(requestServicing: RequestServicing) {
        self.requestServicing = requestServicing
    }

    enum Endpoint: String, EndpointRepresenting {

        case locationDetails = "location_details"

        var path: String {
            return self.rawValue
        }
    }

    func withRestaurantList(execute closure: @escaping (Result<[Restaurant], AnyError>) -> Void) {

        let url: URL! = URL(string: self.urlString(for: .locationDetails))
        let handler: (Result<NetworkResponse, NetworkError>) -> Void = { result in
            switch result {
            case let .success(response):
                var requestResponse: RequestResponse?
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    requestResponse = try decoder.decode(RequestResponse.self, from: response.data)
                } catch {
                    closure(.failure(AnyError(error)))
                }
                if let requestResponse = requestResponse {
                    closure(.success(requestResponse.extractRestaurants()))
                }
            case let .failure(error):
                closure(.failure(AnyError(error)))
            }
        }

        requestServicing.request(
            via: .get,
            url: url,
            queryItems: AbbotsfordRestaurantListProvider.queryItems,
            headerItems: AbbotsfordRestaurantListProvider.headerItems,
            handler: handler)
    }
}

private struct RequestResponse: Codable {
    let bestRatedRestaurant: [RequestRestaurantResponseWrapper]
}

extension RequestResponse {
    func extractRestaurants() -> [Restaurant] {
        return bestRatedRestaurant.map { wrapper in
            Restaurant(name: wrapper.restaurant.name, address: wrapper.restaurant.location.address, imageURL: wrapper.restaurant.photosUrl)
        }
    }
}

private struct RequestRestaurantResponseWrapper: Codable {
    let restaurant: RequestRestaurantResponse
}

private struct RequestRestaurantResponse: Codable {
    let name: String
    let location: RequestLocationResponse
    let photosUrl: URL
}

private struct RequestLocationResponse: Codable {
    let address: String
}


