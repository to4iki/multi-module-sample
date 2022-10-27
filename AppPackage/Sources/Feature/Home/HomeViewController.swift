import Combine
import Environment
import SafariServices
import SwiftUI
import UIKit

public final class HomeViewController: UIHostingController<HomeView> {
  private let environment: EnvironmentType

  private var cancellables: [AnyCancellable] = []

  public init(environment: EnvironmentType) {
    self.environment = environment
    super.init(rootView: HomeView())
    bind(environment: environment)
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func bind(environment: EnvironmentType) {
    rootView.tapCard
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] card in
        guard let linkURL = URL(string: card.linkURLString) else {
          return
        }
        let viewController = SFSafariViewController(url: linkURL)
        viewController.modalPresentationStyle = .pageSheet
        self?.present(viewController, animated: true)
      })
      .store(in: &cancellables)
  }
}
