import Foundation

extension HTTPURLResponse {

    static func stubbedSuccess(url: URL? = nil) -> HTTPURLResponse {
        return HTTPURLResponse(url: url ?? URL(string: "http://apple.com")!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
    }
}
