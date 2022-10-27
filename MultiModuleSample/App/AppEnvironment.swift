import Environment
import UICore
import WalkthroughFeature

public struct AppEnvironment {
  public static let shared = AppEnvironment()
  private init() {}
}

extension AppEnvironment: ViewResolver {
  public func resolveConcrete(_ descriptor: ViewDescriptor.WalkthroughDescriptor)
    -> ViewDescriptor.WalkthroughDescriptor.Output
  {
    WalkthroughViewController(environment: self)
  }
}
