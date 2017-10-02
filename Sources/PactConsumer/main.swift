import Foundation
import PactSwiftPMExample

var swapiClient = PactSwiftPMExample.SwapiClient(baseUrl: "https://swapi.co/api")
var keepAlive = true

print("Welcome to Pactland! fetching now...")

swapiClient.fetchStarWarsCharacter() { (response, statusCode) -> Void in
  print("Status Code:\t\(statusCode)\n\nPayload:\t\t\(response)")
  keepAlive = false
}

let runLoop = RunLoop.current
while keepAlive && runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.5)) {
  print("Fetching...")
}
