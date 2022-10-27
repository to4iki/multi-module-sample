import Data
import Foundation

struct RootUiState {
  var shouldShowWalkthrough: Bool
}

@MainActor
final class RootViewModel<
  DataRepository: WalkthroughRepository
>: ObservableObject {

  @Published private(set) var uiState: RootUiState

  init(
    dataRepository: DataRepository = WalkthroughDataSource.shared
  ) {
    if let walkthrough = try? dataRepository.walkthrough() {
      self.uiState = RootUiState(shouldShowWalkthrough: !walkthrough.isCompletion)
    } else {
      self.uiState = RootUiState(shouldShowWalkthrough: true)
    }
  }
}
