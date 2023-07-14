// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n+Generated {
  public enum Common {
    /// Test
    public static let test = L10n+Generated.tr("Localizable", "common.test", fallback: "Test")
    public enum Alert {
      /// Cancel
      public static let cancel = L10n+Generated.tr("Localizable", "common.alert.cancel", fallback: "Cancel")
      /// OK
      public static let ok = L10n+Generated.tr("Localizable", "common.alert.ok", fallback: "OK")
      /// Alert
      public static let title = L10n+Generated.tr("Localizable", "common.alert.title", fallback: "Alert")
    }
    public enum Error {
      /// Not found path
      public static let notFoundPath = L10n+Generated.tr("Localizable", "common.error.notFoundPath", fallback: "Not found path")
      /// Not found path
      public static let writeFileError = L10n+Generated.tr("Localizable", "common.error.writeFileError", fallback: "Not found path")
    }
  }
  public enum Home {
    /// Description home!
    public static let description = L10n+Generated.tr("Localizable", "home.description", fallback: "Description home!")
    /// Home
    public static let title = L10n+Generated.tr("Localizable", "home.title", fallback: "Home")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n+Generated {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
