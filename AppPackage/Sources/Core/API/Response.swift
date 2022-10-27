import Foundation

/// HTTP network response.
public struct Response<T>: @unchecked Sendable where T: Sendable {
  public let value: T
  public let data: Data
  public let response: URLResponse

  public var statusCode: Int? {
    (response as? HTTPURLResponse)?.statusCode
  }

  public init(value: T, data: Data, response: URLResponse) {
    self.value = value
    self.data = data
    self.response = response
  }

  public func map<U>(_ transform: (T) throws -> U) rethrows -> Response<U> {
    Response<U>(value: try transform(value), data: data, response: response)
  }
}
