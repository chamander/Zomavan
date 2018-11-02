import Foundation

// This file is adapted from the equivalent code available at: https://github.com/antitypical/result

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

extension Result where Value == Void {
    static var success: Result<Void, Error> {
        return .success(())
    }
}

// MARK: -

struct AnyError: Swift.Error {

    let error: Swift.Error

    init(_ underlyingError: Swift.Error) {
        if let e = underlyingError as? AnyError {
            self = e
        } else {
            self.error = underlyingError
        }
    }
}

extension AnyError: CustomStringConvertible {

    var description: String {
        return String(describing: self.error)
    }
}

extension AnyError: LocalizedError {

    private var underlyingLocalizedError: LocalizedError? {
        return self.error as? LocalizedError
    }

    var errorDescription: String? {
        return self.error.localizedDescription
    }

    var failureReason: String? {
        return self.underlyingLocalizedError?.failureReason
    }

    var helpAnchor: String? {
        return self.underlyingLocalizedError?.helpAnchor
    }

    var recoverySuggestion: String? {
        return self.underlyingLocalizedError?.recoverySuggestion
    }
}

// MARK: -

enum NoError: Swift.Error, Equatable {

    static func ==(left: NoError, right: NoError) -> Bool {
        return true
    }
}
