import Combine
import Data
import SwiftUI
import UICore

public struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel<SearchRepositoryRequest>

  private let _tapCard = PassthroughSubject<Card, Never>()
  var tapCard: AnyPublisher<Card, Never> { _tapCard.eraseToAnyPublisher() }

  public init() {
    self._viewModel = StateObject(wrappedValue: HomeViewModel())
  }

  public var body: some View {
    ZStack {
      switch viewModel.uiState {
      case .loading:
        ProgressView()

      case let .editing(text, cards):
        VStack {
          SearchTextField(
            text: text,
            onTextChanged: { text in
              viewModel.onSearchTextChanged(text: text)
            },
            onCommit: {
              Task {
                await viewModel.onSearchCommit()
              }
            }
          )

          ScrollView(showsIndicators: false) {
            ForEach(cards) { card in
              Button {
                _tapCard.send(card)
              } label: {
                CardView(card: card)
              }
            }
          }
          .padding()
        }

      case .error(let error):
        ZStack {
          Text(error.localizedDescription)
        }
      }
    }
  }
}

extension HomeView {
  private struct SearchTextField: View {
    let text: String
    let onTextChanged: (String) -> Void
    let onCommit: () -> Void

    var body: some View {
      TextField(
        L10n.searchKeyText,
        text: Binding(
          get: {
            text
          },
          set: { newValue in
            onTextChanged(newValue)
          }),
        onCommit: {
          onCommit()
        }
      )
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .keyboardType(.asciiCapable)
      .frame(width: UIScreen.main.bounds.width - 40, height: 20)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
