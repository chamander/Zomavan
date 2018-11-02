import Foundation

enum NetworkError: Error {

    case networkError(response: HTTPURLResponse, error: Error)
    case otherError(error: Error)
    case unknownError
}
