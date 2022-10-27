import Foundation

public struct Card: Identifiable {
  public let id: UUID
  public let iconImageURLString: String
  public let title: String
  public let language: String?
  public let star: Int
  public let description: String?
  public let linkURLString: String

  public init(
    id: UUID = .init(),
    iconImageURLString: String,
    title: String,
    language: String?,
    star: Int,
    description: String?,
    linkURLString: String
  ) {
    self.id = id
    self.iconImageURLString = iconImageURLString
    self.title = title
    self.language = language
    self.star = star
    self.description = description
    self.linkURLString = linkURLString
  }
}
