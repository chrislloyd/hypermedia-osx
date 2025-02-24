import Contacts
import Foundation
import Vapor

struct MacContactsWebApp {
  enum ContactsError: Error {
    case accessDenied
  }

  // Function to get all contacts from the Address Book
  static func getContacts() -> [CNContact] {
    let contactStore = CNContactStore()
    let keysToFetch =
      [
        CNContactGivenNameKey,
        CNContactFamilyNameKey,
        CNContactEmailAddressesKey,
        CNContactPhoneNumbersKey,
        CNContactOrganizationNameKey,
      ] as [CNKeyDescriptor]

    // Request access to contacts
    var fetchedContacts: [CNContact] = []

    do {
      let request = CNContactFetchRequest(keysToFetch: keysToFetch)
      try contactStore.enumerateContacts(with: request) { contact, stop in
        fetchedContacts.append(contact)
      }
    } catch {
      print("Error fetching contacts: \(error)")
    }

    return fetchedContacts
  }

  static func Contact(_ contact: CNContact) -> HTMLElement {
    let organization = contact.organizationName
    let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
    let emails = contact.emailAddresses.map { $0.value as String }

    let name = [contact.givenName, contact.familyName]
      .compactMap { $0 as String? }
      .joined(separator: " ")

    var children: [HTMLElement] = [
      element(
        "div", ["class": "name"],
        [
          name.isEmpty ? "No Name" : name
        ])
    ]

    if !organization.isEmpty {
      children.append(element("div", ["class": "organization"], [organization]))
    }

    let infoChildren: [HTMLElement] = [
      phoneNumbers.isEmpty
        ? nil
        : element("div", [String: String](), ["Phone: \(phoneNumbers.joined(separator: ", "))"]),
      emails.isEmpty
        ? nil : element("div", [String: String](), ["Email: \(emails.joined(separator: ", "))"]),
    ].compactMap { $0 }

    if !infoChildren.isEmpty {
      children.append(element("div", ["class": "contact-info"], infoChildren))
    }

    return element("div", ["class": "contact"], children)
  }

  static func Contacts(_ contacts: [CNContact]) -> HTMLElement {
    return element("div", ["id": "contacts-list"], contacts.map(Contact))
  }

  static func configure(_ app: Application) throws {
    app.http.server.configuration.hostname = "127.0.0.1"
    app.http.server.configuration.port = 8080
    try routes(app)
  }

  static func routes(_ app: Application) throws {
    // Route to serve contacts as JSON
    app.get("contacts") { req -> Response in
      let contacts = getContacts()
      do {
        let jsonData = try JSONSerialization.data(
          withJSONObject: contacts, options: .prettyPrinted)
        return Response(
          status: .ok,
          headers: ["Content-Type": "application/json; charset=utf-8"],
          body: .init(data: jsonData)
        )
      } catch {
        return Response(status: .internalServerError)
      }
    }

    // Route to serve the main HTML page
    app.get { req -> Response in
      let contacts = getContacts()

      let page = element(
        "html", [String: String](),
        [
          element(
            "head", [String: String](),
            [
              element("title", [String: String](), ["macOS Contacts"]),
              element(
                "style", [String: String](),
                [
                  """
                    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; }
                    .contact { border-bottom: 1px solid #eee; padding: 10px; }
                    .name { font-weight: bold; }
                    .organization { color: #666; }
                    .contact-info { margin-left: 20px; }
                  """
                ]),
            ]),
          element(
            "body", [String: String](),
            [
              element("h1", [String: String](), ["Contacts"]),
              Contacts(contacts),
            ]),
        ])

      return Response(
        status: .ok,
        headers: ["Content-Type": "text/html; charset=utf-8"],
        body: .init(string: render(page))
      )
    }
  }
}
