// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

public protocol ViewResolver {
  func resolveConcrete(_ descriptor: ViewDescriptor.WalkthroughDescriptor)
    -> ViewDescriptor.WalkthroughDescriptor.Output
}
