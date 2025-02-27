import Contacts
import Html
import Vapor

func index() throws -> Node {
    let contactStore = CNContactStore()
    let keysToFetch =
        [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactOrganizationNameKey,
        ] as [CNKeyDescriptor]

    var contacts: [CNContact] = []
    let request = CNContactFetchRequest(keysToFetch: keysToFetch)
    try contactStore.enumerateContacts(with: request) { contact, stop in
        contacts.append(contact)
    }

    return .document(
        .html(
            .head(
                .title("Hypermedia OSX"),
                .style(
                    unsafe:
                        """
                        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; }
                        .contact { border-bottom: 1px solid #eee; padding: 10px; }
                        .name { font-weight: bold; }
                        .organization { color: #666; }
                        .contact-info { margin-left: 20px; }
                        """)
            ),
            .body(
                .h1("Contacts"),
                .fragment(contacts.map { contact in Contact(contact) })
            )
        )
    )
}
