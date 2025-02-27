import Contacts
import Vapor

func configure(_ app: Vapor.Application) async throws {
    let store = CNContactStore()
    let status = try await store.requestAccess(for: .contacts)
    guard status else {
        fatalError("Contacts access denied")
    }

    try routes(app)
}
