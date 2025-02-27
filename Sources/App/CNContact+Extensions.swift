import Contacts

extension CNContact {
    /// Gets the sort key for a contact (family name, given name or organization)
    fileprivate var sortKey: String {
        if !familyName.isEmpty {
            return familyName
        } else if !givenName.isEmpty {
            return givenName
        } else if !organizationName.isEmpty {
            return organizationName
        } else {
            return ""
        }
    }

    fileprivate static func compareByName(_ lhs: CNContact, _ rhs: CNContact) -> Bool {
        let comparison = lhs.sortKey.localizedCaseInsensitiveCompare(rhs.sortKey)
        return comparison == .orderedAscending
    }
}

extension Array where Element == CNContact {
    /// Sorts contacts by name and returns a new array
    public func sortedByName() -> [CNContact] {
        return self.sorted(by: CNContact.compareByName)
    }

    /// Sorts contacts by name in place
    public mutating func sortByName() {
        self.sort(by: CNContact.compareByName)
    }
}
