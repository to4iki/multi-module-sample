public struct Walkthrough: Encodable, Decodable {
  public var isCompletion: Bool

  public init(isCompletion: Bool) {
    self.isCompletion = isCompletion
  }
}
