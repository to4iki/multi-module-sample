import Foundation

public class UserDefaultsClient {
  public static let shared = UserDefaultsClient()

  private let userDefaults = UserDefaults.standard

  private let jsonEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
  }()

  private let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()

  private init() {}

  public func read<T: Decodable>(forKey defaultName: String) throws -> T {
    guard let data = userDefaults.data(forKey: defaultName) else {
      throw UserDefaultsError.missingValue(key: defaultName)
    }
    return try jsonDecoder.decode(T.self, from: data)
  }

  public func write<T: Encodable>(_ value: T, forKey defaultName: String) throws {
    let data = try jsonEncoder.encode(value)
    userDefaults.set(data, forKey: defaultName)
  }
}

public enum UserDefaultsError: LocalizedError {
  case missingValue(key: String)

  public var errorDescription: String? {
    switch self {
    case .missingValue(let key):
      return "Not value exists for \(key)"
    }
  }
}
