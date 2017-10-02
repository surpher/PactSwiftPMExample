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
    .package(url: "https://github.com/surpher/PactConsumer", from: "0.0.5"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.5.1")
  ],
  targets: [
    .target(
      name: "PactSwiftPMExample",
      dependencies: ["Alamofire"]
    ),
    .testTarget(
      name: "PactSwiftPMExampleTests",
      dependencies: ["PactSwiftPMExample", "PactConsumer"]
    )
  ]
)
```

#### Workflow
1. `mkdir myProject && cd myProject`, `swift package init --type executable`
2. Download the dependencies by running `swift package resolve` in your project root,
3. Edit your `Sources` and add your `Tests`,
4. Build the project by running `swift build`,
5. Test the app works by running `.build/debug/PactSwiftPMExample` - it should print a response from [https://swapi.co/api/people/1/](),
6. Start up the pact mock service by running `pact-mock-service start --pact-specification-version 2.0.0 --log "./tmp/pact.log" --pact-dir "./tmp/pacts" -p 1234`  
(or if you're lazy just `pact-mock-service start`),
7. Run your tests by running `swift test`,
8. Stop the mock service by running `pact-mock_service stop`
9. When your tests pass, you can find your pact contract file in `./tmp/_my-provider_-_my-consumer_.json` file  
_(where provider and consumer is what we set it up in the tests_ `PactConsumer.MockService(provider: "_my-provider_", consumer: "_my-consumer_")`_- if you were wondering...)_

##### Notes
[surpher/PactConsumer](https://github.com/surpher/PactConsumer) is used only for version consistency. Please look into using the real deal by going to [pact-consumer-swift](https://github.com/DiUS/pact-consumer-swift) library (module name `PactConsumerSwift`).


To avoid running 4 commands to start the mock service, build, test and shut down the mock service, there's a `build_test.sh` script in this repo that takes care of starting the _pact-mock-service_, building the project and running the test, then shutting down the service.  
You should probably set up your own test script/s based on your own requirements.
