import SettingFeature
import SwiftUI
import WalkthroughFeature

struct ContentView: View {
  private let pages: [Page]

  init(pages: [Page] = Page.allCases) {
    self.pages = pages
  }

  var body: some View {
    NavigationStack {
      List {
        ForEach(pages) { page in
          NavigationLink {
            switch page {
            case .walkthrough:
              WalkthroughView()
            case .setting:
              SettingView()
            }
          } label: {
            Text(page.rawValue)
          }
        }
      }
      .navigationTitle("Demo")
    }
  }
}

// MARK: - Page

extension ContentView {
  enum Page: String, Identifiable, CaseIterable {
    case walkthrough
    case setting

    var id: String { rawValue }
  }
}
