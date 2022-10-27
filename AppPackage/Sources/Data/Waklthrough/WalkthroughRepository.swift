import UserDefaultsCore

public protocol WalkthroughRepository {
  func walkthrough() throws -> Walkthrough
  func saveWalkthrough(_ walkthrough: Walkthrough) throws
}

public struct WalkthroughDataSource: WalkthroughRepository {
  private enum Key {
    static let walkthrough = "walkthrough"
  }

  public static let shared = WalkthroughDataSource()

  private let client = UserDefaultsClient.shared

  private init() {}

  public func walkthrough() throws -> Walkthrough {
    try client.read(forKey: Key.walkthrough)
  }

  public func saveWalkthrough(_ walkthrough: Walkthrough) throws {
    try client.write(walkthrough, forKey: Key.walkthrough)
  }
}
