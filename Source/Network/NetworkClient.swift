import Foundation

struct NetworkClient: RequestServicing {

    var session: URLSession = .shared

    func request(via method: NetworkMethod, url: URL, queryItems: [URLQueryItem]?, headerItems: [URLHeaderItem]? = nil, handler: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {

        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {

            components.queryItems = queryItems

            let resultantURL: URL! = components.url
            var request = URLRequest(url: resultantURL)
            request.httpMethod = method.httpMethod

            headerItems?.forEach { headerItem in
                request.addValue(headerItem.value, forHTTPHeaderField: headerItem.field)
            }

            let task: URLSessionTask = self.session.dataTask(with: request) { data, response, error in

                let urlResponse: HTTPURLResponse? = response as? HTTPURLResponse

                switch (data, urlResponse, error) {
                case let (nil, response?, error?):
                    handler(.failure(.networkError(response: response, error: error)))
                case let (data?, response?, nil):
                    handler(.success((data, response)))
                default:
                    handler(.failure(.unknownError))
                }
            }

            task.resume()
        }
    }
}
