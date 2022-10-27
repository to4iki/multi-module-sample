import SwiftUI

public struct CardView: View {
  public let card: Card

  public init(card: Card) {
    self.card = card
  }

  public var body: some View {
    VStack(alignment: .leading) {
      AsyncImage(url: URL(string: card.iconImageURLString)) { phase in
        if let image = phase.image {
          RoundedIconImage(image: image)
        } else if let error = phase.error {
          Text(error.localizedDescription)
        } else {
          ProgressView()
        }
      }

      Text(card.title)
        .font(.title)
        .fontWeight(.bold)

      HStack {
        Text(card.language ?? "")
          .font(.footnote)
          .foregroundColor(.gray)

        Spacer()

        starLabel
      }

      Text(card.description ?? "")
        .font(.body)
        .lineLimit(nil)
    }
    .padding(24)
    .overlay(
      RoundedRectangle(cornerRadius: 24)
        .stroke(.gray, lineWidth: 1)
    )
    .frame(minWidth: 140, minHeight: 180)
    .padding()
  }

  public var starLabel: some View {
    Label {
      Text(String(card.star))
        .font(.footnote)
        .foregroundColor(.gray)
    } icon: {
      Image(systemName: "star")
        .renderingMode(.template)
        .foregroundColor(.gray)
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = Card(
      iconImageURLString: "face.smiling.fill",
      title: "SwiftUI",
      language: "Swift",
      star: 1000,
      description: "Declare the user interface and behavior for your app on every platform.",
      linkURLString: "https:exmaple.com"
    )

    return CardView(card: card)
      .previewLayout(.sizeThatFits)
  }
}
