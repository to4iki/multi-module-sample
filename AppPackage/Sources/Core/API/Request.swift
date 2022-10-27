import Foundation

/// HTTP network request.
public struct Request<Response>: @unchecked Sendable {
  public var method: HTTPMethod
  public var url: URL
  public var query: [String: String?]

  public init(
    path: String,
    method: HTTPMethod = .get,
    query: [String: String?] = [:]
  ) {
    self.method = method
    self.url = URL(string: path.isEmpty ? "/" : path)!
    self.query = query
  }
}

// MARK: - HTTPMethod

public enum HTTPMethod: String {
  case get = "GET"
}
