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
        let controller: ZomavanController = ZomavanController()

        window.rootViewController = controller.viewController
        return (window, controller)
    }
}
