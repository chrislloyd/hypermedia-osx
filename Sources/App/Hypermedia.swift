import Foundation

// HTML Element struct
struct HTMLElement {
  let name: String
  let attributes: [String: String]
  let children: [Any]  // Can be String or HTMLElement

  // Render method
  func render() -> String {
    var result = "<\(name)"
    for (key, value) in attributes {
      result += " \(key)=\"\(value)\""
    }
    // Self-closing tag
    if children.isEmpty {
      return result + " />"
    }

    result += ">"

    for child in children {
      if let childElement = child as? HTMLElement {
        result += childElement.render()
      } else if let childString = child as? String {
        result += childString
      }
    }

    // Add closing tag
    result += "</\(name)>"

    return result
  }
}

func element(_ name: String, _ attributes: [String: String] = [:], _ children: [Any] = [])
  -> HTMLElement
{
  return HTMLElement(name: name, attributes: attributes, children: children)
}

func render(_ element: HTMLElement) -> String {
  return "<!DOCTYPE html>\n" + element.render()
}
