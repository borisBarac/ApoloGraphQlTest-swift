// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RMGraphQL",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
      ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RMGraphQL",
            targets: ["RMGraphQL"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apollographql/apollo-ios.git", .upToNextMajor(from: "1.0.0")),
        .package(name: "Api", path: "./GraphQl/Api"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RMGraphQL",
            dependencies: [
                .product(name: "Api", package: "Api"),
                .product(name: "Apollo", package: "apollo-ios"),
                .product(name: "ApolloSQLite", package: "apollo-ios"),
                .product(name: "ApolloTestSupport", package: "apollo-ios"),
            ]),
        .testTarget(
            name: "RMGraphQLTests",
            dependencies: ["RMGraphQL"]),
    ]
)

for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(
    .unsafeFlags([
      "-Xfrontend", "-warn-concurrency",
      "-Xfrontend", "-enable-actor-data-race-checks",
      "-enable-library-evolution",
    ])
  )
}
