import Foundation

@testable import Zomavan

final class RequestSpy: RequestServicing {

    var stubbedResult: Result<NetworkResponse, NetworkError>?

    private(set) var requests: [(method: NetworkMethod, url: URL, queryItems: [URLQueryItem]?, headerItems: [URLHeaderItem]?, handler: (Result<NetworkResponse, NetworkError>) -> Void)] = Array()

    func request(via method: NetworkMethod, url: URL, queryItems: [URLQueryItem]?, headerItems: [URLHeaderItem]?, handler: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        self.requests.append((method: method, url: url, queryItems: queryItems, headerItems: headerItems, handler: handler))
        if let result = stubbedResult {
            handler(result)
        }
    }
}
