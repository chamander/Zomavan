import Foundation

protocol EndpointClient {

    static var baseURLString: String { get }

    associatedtype Endpoint: EndpointRepresenting
}

protocol EndpointRepresenting {

    var path: String { get }
}

extension EndpointClient {

    func urlString(for endpoint: Self.Endpoint) -> String {
        return Self.baseURLString.appending(endpoint.path)
    }
}
