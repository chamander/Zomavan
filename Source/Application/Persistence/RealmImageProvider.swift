import Realm
import RealmSwift
import UIKit

struct RealmImageProvider: ImageProviding {

    var attemptsToRefreshImageUponSuccessfulAccess: Bool = false

    private let underlyingProvider: ImageProviding
    private let configuration: Realm.Configuration
    private var realm: Realm {
        return Realm(unsafelyConfigured: configuration)
    }

    init(underlyingProvider: ImageProviding, configuration: Realm.Configuration = .defaultConfiguration) {
        self.underlyingProvider = underlyingProvider
        self.configuration = configuration
    }

    func withImage(at url: URL, execute closure: @escaping (Result<UIImage, AnyError>) -> Void) {

        let imageQueryResult = realm.imageResults(for: url)
        var successfullyAccessed = false

        if
            let realmImage: Realm_Image = imageQueryResult.first,
            let image: UIImage = UIImage(data: realmImage.imageData)
        {
            closure(.success(image))
            successfullyAccessed = true
        }

        if attemptsToRefreshImageUponSuccessfulAccess || !successfullyAccessed {
            self.underlyingProvider.withImage(at: url) { result in
                switch result {
                case let .success(image):
                    self.realm.updateImage(image, for: url)
                    closure(.success(image))
                case let .failure(error):
                    closure(.failure(AnyError(error)))
                }
            }
        }
    }
}

private extension Realm {

    func imageResults(for url: URL) -> Results<Realm_Image> {
        return self.objects(Realm_Image.self).filter("urlString = %@", url.absoluteString)
    }

    func updateImage(_ image: UIImage, for url: URL) {

        let realmImage = Realm_Image()
        realmImage.urlString = url.absoluteString
        realmImage.imageData = image.pngData() ?? Data()

        try? write {
            delete(imageResults(for: url))
            add(realmImage)
        }
    }
}

final class Realm_Image: Object {

    @objc dynamic var urlString: String = ""
    @objc dynamic var imageData: Data = Data()
}
