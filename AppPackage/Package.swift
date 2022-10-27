// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppPackage",
  defaultLocalization: "en",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "AppFeature",
      targets: ["AppFeature"]
    ),
    .library(
      name: "WidgetFeature",
      targets: ["WidgetFeature"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.2")
  ],
  targets: [
    // Feature(App)
    .target(
      name: "AppFeature",
      dependencies: [
        "HomeFeature",
        "SettingFeature",
        "WalkthroughFeature",
      ],
      path: "./Sources/Feature/App",
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),
    .target(
      name: "HomeFeature",
      dependencies: [
        "Environment",
        "Data",
        "UICore",
      ],
      path: "./Sources/Feature/Home",
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),
    .target(
      name: "SettingFeature",
      dependencies: [
        "Environment",
        "Data",
      ],
      path: "./Sources/Feature/Setting",
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),
    .target(
      name: "WalkthroughFeature",
      dependencies: [
        "DesignSystem",
        "Environment",
        "Data",
      ],
      path: "./Sources/Feature/Walkthrough",
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),

    // Feature(Widget)
    .target(
      name: "WidgetFeature",
      dependencies: [],
      path: "./Sources/Feature/Widget",
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),

    // DesignSystem
    .target(
      name: "DesignSystem",
      dependencies: [],
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
      ]
    ),

    // Environment
    .target(
      name: "Environment",
      dependencies: []
    ),

    // Data
    .target(
      name: "Data",
      dependencies: [
        "UserDefaultsCore",
        "APICore",
      ]
    ),

    // Core
    .target(
      name: "UICore",
      dependencies: [],
      path: "./Sources/Core/UI"
    ),
    .target(
      name: "UserDefaultsCore",
      dependencies: [],
      path: "./Sources/Core/UserDefaults"
    ),
    .target(
      name: "APICore",
      dependencies: [],
      path: "./Sources/Core/API"
    ),
  ]
)
