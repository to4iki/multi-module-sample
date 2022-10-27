/// SeeAlso: https://docs.github.com/ja/rest/reference/search#search-repositories
public struct SearchRepositoryResponse: Decodable {
  public let totalCount: Int
  public let items: [Repository]
}

// MARK: - Repository

extension SearchRepositoryResponse {
  public struct Repository: Decodable, Hashable, Identifiable {
    public let id: Int
    public let name: String
    public let description: String?
    public let stargazersCount: Int
    public let language: String?
    public let htmlUrl: String
    public let owner: Owner
  }
}

// MARK: - Owner

extension SearchRepositoryResponse {
  public struct Owner: Decodable, Hashable, Identifiable {
    public let id: Int
    public let avatarUrl: String
  }
}
