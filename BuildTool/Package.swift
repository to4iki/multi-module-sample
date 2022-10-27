// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BuildTool",
  platforms: [.macOS(.v10_15)],
  dependencies: [
    .package(url: "https://github.com/apple/swift-format", branch: "main"),
    .package(url: "https://github.com/yonaskolb/Mint.git", from: "0.17.5"),
  ],
  targets: []
)
