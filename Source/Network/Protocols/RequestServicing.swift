import Foundation

typealias NetworkResponse = (data: Data, response: HTTPURLResponse)

protocol RequestServicing {

    func request(via method: NetworkMethod, url: URL, with queryItems: [URLQueryItem]?, handler: @escaping  (Result<NetworkResponse, NetworkError>) -> Void)
}
