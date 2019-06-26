# Consumer Driven Contracts Testing using Swift Package Manager

[![Build Status](https://travis-ci.org/surpher/PactSwiftPMExample.svg?branch=master)](https://travis-ci.org/surpher/PactSwiftPMExample)
[![Swift Package Manager Compatible](https://img.shields.io/badge/swift_package_manager-compatible-brightgreen.svg)]()
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)
[![Twitter](https://img.shields.io/badge/twitter-@pact__up-blue.svg?style=flat)](http://twitter.com/pact_up)

This project is an example of how to use [pact-consumer-swift](https://github.com/DiUS/pact-consumer-swift) framework.

## Installation

### Install the [pact-mock_service](https://github.com/pact-foundation/pact-ruby-standalone/releases)

In your terminal run:

```bash
brew tap surpher/pact-ruby-standalone
brew update
```

_This pact mock service will stand in for your API provider and run on localhost._

## Running this demo project

1. Clone the repo
2. Sort out the dependencies
3. Navigate to the root folder
4. run `./scripts/build_test.sh` to run Pact tests
5. run the app `.build/debug/PactConsumer` (the executable will call `https://swapi.co/api/people/1/` print the progress and eventually the result returned from the API)

## Your Project

##### Init your brand new executable Swift project

`swift package init --type executable`

#### Prepare your dependencies in `Package.swift` manifest file

This is an example from this project where Alamofire is used to make the network call:

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PactSwiftPMExample",
    dependencies: [
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.8.2"),
      .package(url: "https://github.com/DiUS/pact-consumer-swift", from: "0.6.0")
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

Write your application...


#### Overall Workflow Example
1. `mkdir myProject && cd myProject`, `swift package init --type executable`
2. Resolve dependencies by running `swift package resolve` in your project's root,
3. Add your `Tests` and edit your `Sources`,
4. Build the project by running `swift build`,
5. Check if the app works by running `.build/debug/PactConsumer` (that's the target holding `main.swift` file) - by default it should print a response from [https://swapi.co/api/people/1/](),
6. Start up the pact mock service by running `pact-mock-service start --pact-specification-version 2.0.0 --log "./tmp/pact.log" --pact-dir "./tmp/pacts" -p 1234`  
(or if you're lazy just `pact-mock-service start`),
7. Run your tests by running `swift test`,
8. Stop the mock service by running `pact-mock_service stop`
9. When your tests pass, you can find your pact contract file in `./tmp/pacts/_my-provider_-_my-consumer_.json` file  
_(where provider and consumer is what we set it up in the PactTests_ `starWarsProvider = PactConsumerSwift.MockService(provider: "_my-provider_", consumer: "_my-consumer_")`_- if you were wondering...)_

##### Notes
Following best practices, you should write and run your unit tests before checking if the app works, do you agree?  

To avoid running 4 commands to start the mock service, build, test and shut down the mock service, there's a `scripts/build_test.sh` script in this repo that takes care of creating the `./tmp` folder, starting up the _pact-mock-service_, building the project, running the test, and then shutting down the service.  
You should probably set up your own test script/s based on your own requirements.
