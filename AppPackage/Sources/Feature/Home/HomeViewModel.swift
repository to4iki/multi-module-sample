import Data
import Foundation
import UICore

enum HomeUiState {
  case loading
  case editing(text: String, cards: [Card])
  case error(HomeError)
}

enum HomeError: LocalizedError {
  case repositorySearchFailed
}

@MainActor
final class HomeViewModel<
  DataRepository: SearchRepositoryRepository
>: ObservableObject {

  @Published private(set) var uiState: HomeUiState
  private let dataRepository: DataRepository

  init(
    dataRepository: DataRepository = SearchRepositoryRequest.shared
  ) {
    self.uiState = HomeUiState.editing(text: "", cards: [])
    self.dataRepository = dataRepository
  }

  func onSearchTextChanged(text: String) {
    guard case .editing(_, let cards) = uiState else {
      return
    }
    self.uiState = .editing(text: text, cards: cards)
  }

  func onSearchCommit() async {
    guard case .editing(let text, _) = uiState else {
      return
    }
    self.uiState = .loading

    do {
      let response = try await dataRepository.search(query: text)
      let cards = response.items.map(card(from:))
      self.uiState = .editing(text: text, cards: cards)
    } catch {
      self.uiState = .error(.repositorySearchFailed)
    }
  }

  private func card(from apiResponse: SearchRepositoryResponse.Repository) -> Card {
    Card(
      iconImageURLString: apiResponse.owner.avatarUrl,
      title: apiResponse.name,
      language: apiResponse.language,
      star: apiResponse.stargazersCount,
      description: apiResponse.description,
      linkURLString: apiResponse.htmlUrl
    )
  }
}
