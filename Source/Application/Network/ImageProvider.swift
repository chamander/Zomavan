import UIKit

struct ImageProvider {

    private let requestServicing: RequestServicing

    init(requestServicing: RequestServicing) {
        self.requestServicing = requestServicing
    }

    func withImage(at url: URL, execute closure: @escaping (Result<UIImage, AnyError>) -> Void) {
        self.requestServicing.request(via: .get, url: url, queryItems: nil, headerItems: nil) { result in
            switch result {
            case let .success(data, _):
                if let image = UIImage(data: data) {
                    closure(.success(image))
                } else {
                    closure(.failure(AnyError(ErrorMessage("Image failed to load."))))
                }
            case let .failure(error):
                closure(.failure(AnyError(error)))
            }
        }
    }
}
