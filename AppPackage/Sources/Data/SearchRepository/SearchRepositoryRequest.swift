import APICore
import Foundation

public protocol SearchRepositoryRepository {
  func search(query: String) async throws -> SearchRepositoryResponse
}

public struct SearchRepositoryRequest: SearchRepositoryRepository {
  public static let shared = SearchRepositoryRequest()

  private let client = APIClient(baseURL: URL(string: "https://api.github.com")!)

  private init() {}

  public func search(query: String) async throws -> SearchRepositoryResponse {
    let request = Request<SearchRepositoryResponse>(
      path: "/search/repositories",
      method: .get,
      query: [
        "q": query,
        "order": "desc",
      ]
    )
    return try await client.send(request).value
  }
}
