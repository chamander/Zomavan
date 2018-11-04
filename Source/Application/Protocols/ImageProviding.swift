import UIKit

protocol ImageProviding {
    func withImage(at url: URL, execute closure: @escaping (Result<UIImage, AnyError>) -> Void)
}
