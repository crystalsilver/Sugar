#if os(OSX)
  import Cocoa
#else
  import UIKit
#endif

public struct Application {
  public static var name: String = {
    return !displayName.isEmpty ? displayName : bundleName
  }()

  public static var versionNumber: String = Application.getString("CFBundleShortVersionString")
  public static var buildNumber: String = Application.getString("CFBundleVersion")
  public static var executableName: String = Application.getString("CFBundleExecutable")
  public static var bundleId: String = Application.getString("CFBundleIdentifier")

  public static var schemes: [String] = {
    guard let infoDictionary = Bundle.main.infoDictionary,
      let urlTypes = infoDictionary["CFBundleURLTypes"] as? JSONArray,
      let urlType = urlTypes.first,
      let urlSchemes = urlType["CFBundleURLSchemes"] as? [String]
      else {
        return []
    }

    return urlSchemes
  }()

  public static var mainScheme: String? = schemes.first

  // MARK: - Helper

  private static var displayName: String = Application.getString("CFBundleDisplayName")
  private static var bundleName: String = Application.getString("CFBundleName")

  private static func getString(_ key: String) -> String {
    guard let infoDictionary = Bundle.main.infoDictionary,
      let value = infoDictionary[key] as? String
      else {
        return ""
    }

    return value
  }
}
