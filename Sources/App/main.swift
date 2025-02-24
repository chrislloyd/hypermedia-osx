import Contacts
import Foundation
import Vapor

// Request access to contacts and start the server
try await MacContactsWebApp.main()

// Main entry point
extension MacContactsWebApp {
  static func main() async throws {
    let store = CNContactStore()
    try await store.requestAccess(for: CNEntityType.contacts)

    let app = try await Application.make(Environment.detect())
    try configure(app)
    try await app.execute()
  }
}
