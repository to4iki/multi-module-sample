import Combine
import Data
import DesignSystem
import SwiftUI

public struct WalkthroughView: View {
  @StateObject private var viewModel: WalkthroughViewModel<WalkthroughDataSource>

  private let _tapStartButton = PassthroughSubject<Void, Never>()
  public var tapStartButton: AnyPublisher<Void, Never> { _tapStartButton.eraseToAnyPublisher() }

  public init() {
    self._viewModel = StateObject(wrappedValue: WalkthroughViewModel())
  }

  public var body: some View {
    TabView {
      aboutView
      startAppView
    }
    .background(ColorStyle.primary.swiftUIColor)
    .tabViewStyle(PageTabViewStyle())
    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
  }

  private var aboutView: some View {
    Text(L10n.aboutDescription)
  }

  private var startAppView: some View {
    Button(L10n.startButton) {
      viewModel.completeWalkthrough()
      _tapStartButton.send(())
    }
  }
}

struct WalkthroughView_Previews: PreviewProvider {
  static var previews: some View {
    WalkthroughView()
  }
}
