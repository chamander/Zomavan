import Foundation
import Nimble
import Quick

@testable import Zomavan

final class AbbotsfordRestaurantListProviderTests: QuickSpec {

    override func spec() {

        describe("an Abbotsford Restaurant List Provider") {

            var subject: AbbotsfordRestaurantListProvider!
            var requestSpy: RequestSpy!

            afterEach {
                subject = nil
                requestSpy = nil
            }

            beforeEach {
                requestSpy = RequestSpy()
                subject = AbbotsfordRestaurantListProvider(requestServicing: requestSpy)
            }

            it("provides the correct URL to hit") {
                subject.withRestaurantList { _ in () }
                expect(requestSpy.requests.last?.url.absoluteString).to(equal("https://developers.zomato.com/api/v2.1/location_details"))
                expect(requestSpy.requests.last?.queryItems).to(contain(
                    [
                        URLQueryItem(name: "entity_id", value: "98284"),
                        URLQueryItem(name: "entity_type", value: "subzone")
                    ]
                ))
            }

            it("requests a maximum of ten restaurants") {
                subject.withRestaurantList { _ in () }
                expect(requestSpy.requests.last?.queryItems).to(contain(URLQueryItem(name: "count", value: "10")))
            }

            it("correctly parses data in the correct format") {

                var resultantRestaurants: [Restaurant]?

                requestSpy.stubbedResult = .success((data: StubData.restaurantListJSONData, response: .stubbedSuccess()))
                subject.withRestaurantList { result in
                    if case let .success(list) = result {
                        resultantRestaurants = list
                    }
                }
                expect(resultantRestaurants).toEventually(equal(
                    [
                        Restaurant(
                            name: "Jinda Thai Restaurant",
                            address: "7 Ferguson Street, Abbotsford, Melbourne",
                            imageURL: URL(string: "https://www.zomato.com")!),
                        Restaurant(
                            name: "Au79",
                            address: "27-29 Nicholson Street, Abbotsford, Melbourne",
                            imageURL: URL(string: "https://www.zomato.com")!),
                    ]
                ))
            }
        }
    }

    private struct StubData {

        static let restaurantListJSON: String =
"""
{
    "best_rated_restaurant": [
        {
            "restaurant": {
                "name": "Jinda Thai Restaurant",
                "location": {
                    "address": "7 Ferguson Street, Abbotsford, Melbourne"
                },
                "photos_url": "https://www.zomato.com"
            }
        },
        {
            "restaurant": {
                "name": "Au79",
                "location": {
                    "address": "27-29 Nicholson Street, Abbotsford, Melbourne"
                },
                "photos_url": "https://www.zomato.com"
            }
        }
    ]
}
"""

        static var restaurantListJSONData: Data {
            return restaurantListJSON.data(using: .utf8)!
        }
    }
}
