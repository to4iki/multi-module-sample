import Combine
import SwiftUI

public struct SettingView: View {
  @StateObject private var viewModel: SettingViewModel

  private let _tapItem = PassthroughSubject<SettingUiState.SectionModel.Item, Never>()
  var tapItem: AnyPublisher<SettingUiState.SectionModel.Item, Never> {
    _tapItem.eraseToAnyPublisher()
  }

  public init() {
    self._viewModel = StateObject(wrappedValue: SettingViewModel())
  }

  public var body: some View {
    List {
      ForEach(viewModel.uiState.sections, id: \.self) { section in
        Section {
          ForEach(section.items, id: \.self) { item in
            Button {
              _tapItem.send(item)
            } label: {
              Text(item.rawValue)
            }
          }
        } header: {
          Text(section.title)
        }
      }
      .listStyle(.insetGrouped)
    }
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
  }
}
