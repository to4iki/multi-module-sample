import Data
import Foundation

struct WalkthroughUiState {
  var walkthroughError: WalkthroughError?
}

enum WalkthroughError: LocalizedError {
  case walkthroughSaveFailed
}

@MainActor
final class WalkthroughViewModel<
  DataRepository: WalkthroughRepository
>: ObservableObject {

  @Published private(set) var uiState: WalkthroughUiState
  private let dataRepository: DataRepository

  init(
    dataRepository: DataRepository = WalkthroughDataSource.shared
  ) {
    self.uiState = WalkthroughUiState()
    self.dataRepository = dataRepository
  }

  func completeWalkthrough() {
    do {
      try dataRepository.saveWalkthrough(Walkthrough(isCompletion: true))
    } catch {
      uiState.walkthroughError = .walkthroughSaveFailed
    }
  }
}
