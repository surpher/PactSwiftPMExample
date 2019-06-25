// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PactSwiftPMExample",
    dependencies: [
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.5.1"),
      .package(url: "https://github.com/DiUS/pact-consumer-swift", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
          name: "PactConsumer",
          dependencies: ["PactSwiftPMExample"],
          path: "Sources/PactConsumer"),
        .target(
          name: "PactSwiftPMExample",
          dependencies: ["Alamofire"]),
        .testTarget(
          name: "PactSwiftPMExampleTests",
          dependencies: ["PactSwiftPMExample", "PactConsumerSwift"]),
    ]
)
