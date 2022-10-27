import Data
import Environment
import HomeFeature
import SettingFeature
import UIKit

public final class RootViewController: UIViewController {
  private let viewModel: RootViewModel<WalkthroughDataSource>
  private let environment: EnvironmentType

  private let _tabBarController = UITabBarController()

  public init(environment: EnvironmentType) {
    self.viewModel = RootViewModel()
    self.environment = environment
    super.init(nibName: nil, bundle: nil)

    addChild(_tabBarController)
    view.addSubview(_tabBarController.view)
    _tabBarController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      _tabBarController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      _tabBarController.view.topAnchor.constraint(equalTo: view.topAnchor),
      _tabBarController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      _tabBarController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    _tabBarController.didMove(toParent: self)
  }

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    let home = UINavigationController(
      rootViewController: HomeViewController(environment: environment)
    )
    let setting = UINavigationController(
      rootViewController: SettingViewController(environment: environment)
    )

    home.tabBarItem = UITabBarItem(
      title: L10n.homeScreen, image: UIImage(systemName: "house"), tag: 0
    )
    setting.tabBarItem = UITabBarItem(
      title: L10n.settingScreen, image: UIImage(systemName: "gear"), tag: 1
    )

    _tabBarController.setViewControllers([home, setting], animated: false)
    _tabBarController.selectedIndex = 0
  }

  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if viewModel.uiState.shouldShowWalkthrough {
      let viewController = environment.resolve(ViewDescriptor.WalkthroughDescriptor())
      present(viewController, animated: false)
    }
  }
}
