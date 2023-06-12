// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "components",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "components",
            targets: ["components"]),
    ],
    dependencies: [
        .package(url: "https://github.com/lamnguyen1112/core.git", branch: "main"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", branch: "develop"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", branch: "main"),
        .package(url: "https://github.com/RxSwiftCommunity/Action.git", branch: "master"),
        .package(url: "https://github.com/RxSwiftCommunity/RxSwiftExt.git", branch: "main"),
        .package(url: "https://github.com/instacart/Nantes.git", branch: "master"),
//        .package(url: "https://github.com/SteveBarnegren/AttributedStringBuilder.git", branch: "master"),
        .package(url: "https://github.com/slackhq/PanModal.git", branch: "master"),
        .package(url: "https://github.com/huri000/SwiftEntryKit.git", branch: "master"),
        .package(url: "https://github.com/kean/Nuke.git", branch: "main"),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "components",
            dependencies: ["core", "SnapKit", "RxSwift", "Action", "RxSwiftExt", "SkeletonView", "PanModal", "Nantes", "SwiftEntryKit", "Nuke"],
            path: "Sources",
            resources: [.copy("Assets")]
        ),
        .testTarget(
            name: "componentsTests",
            dependencies: ["components", "core", "SnapKit", "RxSwift", "Action", "RxSwiftExt", "SkeletonView", "PanModal", "Nantes", "SwiftEntryKit", "Nuke"],
            path: "Tests"
        ),
    ]
)
