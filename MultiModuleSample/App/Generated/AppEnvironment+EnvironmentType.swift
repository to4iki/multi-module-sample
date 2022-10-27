// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Environment

extension AppEnvironment: EnvironmentType {
  public func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output {
    switch descriptor {
    case let walkthroughDescriptor as ViewDescriptor.WalkthroughDescriptor:
      return resolveConcrete(walkthroughDescriptor) as! Descriptor.Output
    default:
      // unavailable
      fatalError("Unknown descriptor!")
    }
  }
}
