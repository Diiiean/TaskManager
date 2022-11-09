import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                let window = UIWindow(windowScene: windowScene)
                let splashScreen = SplashScreen()
                let mainController = splashScreen
                let controller = MenuViewController()
                let navController = UINavigationController(rootViewController: mainController)
        navController.navigationBar.barStyle = .default
//        navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        navController.navigationBar.tintColor = .systemTeal
                window.rootViewController = navController
                self.window = window
                window.makeKeyAndVisible()
    }
}

