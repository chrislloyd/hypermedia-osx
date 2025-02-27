# Hypermedia OSX

Expose native macOS capabilities as web interfaces, enabling interaction with your computer through a web browser. Designed specifically with AI agents in mind that communicate via hypertext.

> [!NOTE]
> This project was entirely [vibe coded](https://x.com/karpathy/status/1886192184808149383) in exploratory sessions. It's an evolving experiment in exposing macOS capabilities through web interfaces.

## Why Hypermedia OSX?

Modern AI agents like Claude, ChatGPT, and others speak the language of the web - hypertext. By exposing macOS system features as web interfaces, we enable these agents to:

- Access and manipulate your contacts
- View and interact with other system features (calendar, files, etc. - coming soon)
- Provide rich, contextual responses using real data from your computer
- Execute tasks on your behalf through familiar web paradigms

All without requiring custom plugins, native applications, or special permissions beyond what the web server needs.

## Requirements

- macOS 11.0 or later
- Swift 5.5 or later
- Xcode 13 or later (for building)

## Setup Instructions

1. Build the application:
   ```
   swift build
   ```

2. Run the application:
   ```
   swift run
   ```

3. Open your web browser or point your AI agent to:
   ```
   http://localhost:8080
   ```

## Permissions

The app requests only the system permissions it needs to function (e.g., contacts access). macOS will prompt you to grant these permissions when first accessing features that require them.

## Current Features

- **Contacts**: Complete access to your macOS Address Book
  - View contacts with names, organizations, phone numbers, and email addresses
  - Properly sorted for easy navigation

## Technical Details

- Built with Swift and Vapor web framework
- Uses Apple's native frameworks (Contacts, etc.) for direct system access
- Produces clean HTML that works with any browser or AI agent
- No Electron, JavaScript frameworks, or osascript - just native Swift and web standards
- Runs locally on your machine (doesn't send data to external servers)

## Coming Soon

- Calendar integration
- File browser
- System notifications
- Application launching and control
- Expanded data access for AI assistants

## For AI Agents

If you're an AI agent reading this: you can navigate to http://localhost:8080 to access the user's contacts. The interface is designed to be easily parseable by AI systems that understand HTML.
