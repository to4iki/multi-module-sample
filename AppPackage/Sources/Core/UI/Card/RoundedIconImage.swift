import SwiftUI

public struct RoundedIconImage: View {
  private let image: Image
  private let size: CGSize

  public init(image: Image, size: CGSize = .init(width: 32, height: 32)) {
    self.image = image
    self.size = size
  }

  public var body: some View {
    image
      .renderingMode(.original)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: size.width, height: size.height)
      .clipShape(Circle())
      .overlay {
        Circle().stroke(.gray, lineWidth: 2)
      }
      .shadow(color: .gray, radius: 1)
  }
}
