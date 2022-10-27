import Combine
import Environment
import SwiftUI
import UIKit

public final class SettingViewController: UIHostingController<SettingView> {
  private let environment: EnvironmentType

  private var cancellables: [AnyCancellable] = []

  public init(environment: EnvironmentType) {
    self.environment = environment
    super.init(rootView: SettingView())
    bind(environment: environment)
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = L10n.screen
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
  }

  private func bind(environment: EnvironmentType) {
    rootView.tapItem
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] item in
        switch item {
        case .walkthrough:
          let viewController = environment.resolve(ViewDescriptor.WalkthroughDescriptor())
          self?.present(viewController, animated: true)
        }
      })
      .store(in: &cancellables)
  }
}
