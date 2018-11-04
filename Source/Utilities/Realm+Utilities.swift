import RealmSwift

extension Realm {

    convenience init(unsafelyConfigured configuration: Configuration) {
        try! self.init(configuration: configuration)
    }
}
