# Consumer Driven Contracts Testing with Swift Package Manager

[![Build Status](https://travis-ci.org/surpher/PactSwiftPMExample.svg?branch=master)](https://travis-ci.org/surpher/PactSwiftPMExample)
[![Swift Package Manager Compatible](https://img.shields.io/badge/swift_package_manager-compatible-brightgreen.svg)]()
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)
[![Twitter](https://img.shields.io/badge/twitter-@pact__up-blue.svg?style=flat)](http://twitter.com/pact_up)

This project is an example of how to use `pact-consumer-swift` framework.

## Installation

##### Install the [pact-mock_service](https://github.com/pact-foundation/pact-mock_service)
Run in your terminal: `gem install pact-mock_service`  
_This pact mock service will stand in for your API provider and run on localhost._

##### Init your executable Swift project
`swift package init --type executable`

#### Prepare your dependencies in `Package.swift` manifest file
```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PactSwiftPMExample",
    dependencies: [
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.5.1"),
      .package(url: "https://github.com/DiUS/pact-consumer-swift", from: "0.5.0")
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
```

#### Workflow
1. `mkdir myProject && cd myProject`, `swift package init --type executable`
2. Download the dependencies by running `swift package resolve` in your project root,
3. Edit your `Sources` and add your `Tests`,
4. Build the project by running `swift build`,
5. Check if the app works by running `.build/debug/PactConsumer` (that's the target holding `main.swift` file) - it should print a response from [https://swapi.co/api/people/1/](),
6. Start up the pact mock service by running `pact-mock-service start --pact-specification-version 2.0.0 --log "./tmp/pact.log" --pact-dir "./tmp/pacts" -p 1234`  
(or if you're lazy just `pact-mock-service start`),
7. Run your tests by running `swift test`,
8. Stop the mock service by running `pact-mock_service stop`
9. When your tests pass, you can find your pact contract file in `./tmp/_my-provider_-_my-consumer_.json` file  
_(where provider and consumer is what we set it up in the PactTests_ `starWarsProvider = PactConsumerSwift.MockService(provider: "_my-provider_", consumer: "_my-consumer_")`_- if you were wondering...)_

##### Notes
Following best practices, you should write your tests first then check if the app works, do you agree?  

To avoid running 4 commands to start the mock service, build, test and shut down the mock service, there's a `build_test.sh` script in this repo that takes care of creating the `./tmp` folder, starting up the _pact-mock-service_, building the project, running the test, and then shutting down the service.  
You should probably set up your own test script/s based on your own requirements.
