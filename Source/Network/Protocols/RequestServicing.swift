import Foundation

typealias NetworkResponse = (data: Data, response: HTTPURLResponse)

protocol RequestServicing {

    func request(via method: NetworkMethod, url: URL, queryItems: [URLQueryItem]?, headerItems: [URLHeaderItem]?, handler: @escaping (Result<NetworkResponse, NetworkError>) -> Void)
}

struct URLHeaderItem {
    let field: String
    let value: String
}
