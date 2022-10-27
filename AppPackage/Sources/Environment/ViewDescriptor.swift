import Foundation
import UIKit

/// SeeAlso: https://techlife.cookpad.com/entry/2021/06/16/110000
public enum ViewDescriptor {}

extension ViewDescriptor {
  public struct WalkthroughDescriptor: TypedDescriptor {
    public typealias Output = UIViewController

    public init() {}
  }
}
