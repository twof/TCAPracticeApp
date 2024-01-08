// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TCAPracticeCore",
    platforms: [
      .iOS(.v17),
      .macOS(.v13)
    ],
    products: [
        .library(
            name: "TCAPracticeCore",
            targets: ["TCAPracticeCore"]),
    ],
    dependencies: [
      .package(
        url: "https://github.com/pointfreeco/swift-composable-architecture",
        from: "1.0.0"
      ),
      .package(url: "https://github.com/realm/SwiftLint.git", from: "0.54.0")
    ],
    targets: [
        .target(
            name: "TCAPracticeCore",
            dependencies: [
              .product(
                name: "ComposableArchitecture",
                package: "swift-composable-architecture"
              )
            ],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .testTarget(
            name: "TCAPracticeCoreTests",
            dependencies: [
              "TCAPracticeCore",
              .product(
                name: "ComposableArchitecture",
                package: "swift-composable-architecture"
              )
            ],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
    ]
)
