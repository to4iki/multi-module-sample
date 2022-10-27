import Foundation

public actor APIClient {
  public struct Configuration: @unchecked Sendable {
    public var baseURL: URL
    public var sessionConfiguration: URLSessionConfiguration
    public var decoder: JSONDecoder

    public init(
      baseURL: URL,
      sessionConfiguration: URLSessionConfiguration = .default
    ) {
      self.baseURL = baseURL
      self.sessionConfiguration = sessionConfiguration
      self.decoder = JSONDecoder()
      self.decoder.keyDecodingStrategy = .convertFromSnakeCase
      self.decoder.dateDecodingStrategy = .iso8601
    }
  }

  private let configuration: Configuration
  private let session: URLSession
  private let decoder: JSONDecoder

  public init(baseURL: URL) {
    let configuration = Configuration(baseURL: baseURL, sessionConfiguration: .default)
    self.init(configuration: configuration)
  }

  public init(configuration: Configuration) {
    self.configuration = configuration
    self.session = URLSession(configuration: configuration.sessionConfiguration)
    self.decoder = configuration.decoder
  }

  public func send<T: Decodable>(_ request: Request<T>) async throws -> Response<T> {
    let response = try await data(for: request)
    let value: T = try decoder.decode(T.self, from: response.data)
    return response.map { _ in value }
  }

  private func data<T>(for request: Request<T>) async throws -> Response<Data> {
    let request = try await makeURLRequest(for: request)
    do {
      let (data, urlResponse) = try await session.data(for: request)
      let response = Response<Data>(value: data, data: data, response: urlResponse)
      try validate(response: response)
      return response
    } catch {
      throw APIError.loadError(error)
    }
  }

  private func makeURLRequest<T>(for request: Request<T>) async throws -> URLRequest {
    let url = try makeURL(for: request)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    return urlRequest
  }

  private func makeURL<T>(for request: Request<T>) throws -> URL {
    func url() -> URL {
      let _url = request.url
      if _url.scheme == nil {
        return configuration.baseURL.appending(path: _url.absoluteString)
      } else {
        return _url
      }
    }

    guard var component = URLComponents(url: url(), resolvingAgainstBaseURL: false) else {
      throw URLError(.badURL)
    }
    if !request.query.isEmpty {
      component.queryItems = request.query.map { query in
        URLQueryItem(name: query.key, value: query.value)
      }
    }
    guard let url = component.url else {
      throw URLError(.badURL)
    }
    return url
  }

  private func validate<T>(response: Response<T>) throws {
    guard let httpResponse = response.response as? HTTPURLResponse else {
      return
    }
    guard (200..<300).contains(httpResponse.statusCode) else {
      throw APIError.unacceptableStatusCode(httpResponse.statusCode)
    }
  }
}

// MARK: - APIError

public enum APIError: Error {
  case unacceptableStatusCode(Int)
  case loadError(Error)
}
