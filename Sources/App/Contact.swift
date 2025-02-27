import Contacts
import Html

public func Contact(_ contact: CNContact) -> Node {
    let organization = contact.organizationName
    let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
    let emails = contact.emailAddresses.map { $0.value as String }

    let name = [contact.givenName, contact.familyName]
        .compactMap { $0 as String? }
        .joined(separator: " ")

    var children: [Node] = [
        .div(attributes: [.class("name")], .text(name.isEmpty ? "No Name" : name))
    ]

    if !organization.isEmpty {
        children.append(.div(attributes: [.class("organization")], .text(organization)))
    }

    var infoChildren: [Node] = []

    if !phoneNumbers.isEmpty {
        infoChildren.append(.div(.text("Phone: \(phoneNumbers.joined(separator: ", "))")))
    }

    if !emails.isEmpty {
        infoChildren.append(.div(.text("Email: \(emails.joined(separator: ", "))")))
    }

    if !infoChildren.isEmpty {
        children.append(.div(attributes: [.class("contact-info")], .fragment(infoChildren)))
    }

    return .div(attributes: [.class("contact")], .fragment(children))
}
