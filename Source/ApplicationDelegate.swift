import UIKit

@UIApplicationMain
final class ApplicationDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var applicationController: ZomavanController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        defer { self.window?.makeKeyAndVisible() }

        let (window, applicationController) = self.initialiseApplication()

        self.window = window
        self.applicationController = applicationController
        return true
    }

    private func initialiseApplication() -> (window: UIWindow, controller: ZomavanController) {

        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        let controller: ZomavanController = ZomavanController(dependencies: ApplicationDependencies.production)

        window.rootViewController = controller.viewController
        return (window, controller)
    }
}

typealias ApplicationDependenciesProvider = HasRestaurantListProvider & HasImageProvider

private struct ApplicationDependencies: ApplicationDependenciesProvider {

    static let production: ApplicationDependencies = ApplicationDependencies(requestServicing: NetworkClient())

    init(requestServicing: RequestServicing) {
        self.restaurantListProvider = ZomatoRestaurantListProvider(requestServicing: requestServicing)
        self.imageProvider = ImageProvider(requestServicing: requestServicing)
    }

    let imageProvider: ImageProvider
    let restaurantListProvider: ZomatoRestaurantListProviding
}
