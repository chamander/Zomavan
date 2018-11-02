import Foundation

struct NetworkClient: RequestServicing {

    var session: URLSession = .shared

    func request(via method: NetworkMethod, url: URL, with queryItems: [URLQueryItem]?, handler: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {

        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {

            components.queryItems = queryItems

            let resultantURL: URL! = components.url
            var request = URLRequest(url: resultantURL)
            request.httpMethod = method.httpMethod

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
