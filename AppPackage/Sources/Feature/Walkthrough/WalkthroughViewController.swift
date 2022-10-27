import Combine
import Environment
import SwiftUI
import UIKit

public final class WalkthroughViewController: UIHostingController<WalkthroughView> {
  private let environment: EnvironmentType

  private var cancellables: [AnyCancellable] = []

  public init(environment: EnvironmentType) {
    self.environment = environment
    super.init(rootView: WalkthroughView())
    bind(environment: environment)
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func bind(environment: EnvironmentType) {
    rootView.tapStartButton
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] item in
        self?.dismiss(animated: true)
      })
      .store(in: &cancellables)
  }
}
