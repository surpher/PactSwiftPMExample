import Foundation
import Alamofire

print("Welcome to Pactland! fetching now...")

var swapiClient = SwapiClient(baseUrl: "https://swapi.co/api")
var keepAlive = true

swapiClient.fetchStarWarsCharacter() { (response, statusCode) -> Void in
  print("Status Code:\t\(statusCode)\n\nPayload:\t\t\(response)")
  keepAlive = false
}

let runLoop = RunLoop.current
while keepAlive && runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.5)) {
  print("Fetching...")
}
