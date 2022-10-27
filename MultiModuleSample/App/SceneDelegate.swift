import AppFeature
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene, willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else {
      return
    }
    let environment = AppEnvironment.shared
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = RootViewController(environment: environment)
    self.window = window
    window.makeKeyAndVisible()
  }
}
