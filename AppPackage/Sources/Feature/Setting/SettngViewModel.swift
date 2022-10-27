import Foundation

struct SettingUiState {
  struct SectionModel: Hashable {
    enum Item: String {
      case walkthrough
    }

    let title: String
    let items: [Item]
  }

  var sections: [SectionModel]
}

@MainActor
final class SettingViewModel: ObservableObject {
  @Published private(set) var uiState: SettingUiState

  init() {
    var sections: [SettingUiState.SectionModel] = []

    #if DEBUG
      sections.append(SettingUiState.SectionModel(title: L10n.debugSection, items: [.walkthrough]))
    #endif

    self.uiState = SettingUiState(sections: sections)
  }
}
