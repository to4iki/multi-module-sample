public protocol EnvironmentType {
  func resolve<Descriptor: TypedDescriptor>(_ descriptor: Descriptor) -> Descriptor.Output
}
