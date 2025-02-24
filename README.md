# macOS Contacts Web App

A simple web app that displays your macOS Address Book contacts in a web browser. This app uses Swift with the Contacts framework to access your contacts and serves them via a local web server.

> [!NOTE]
> This project was entirely [vibe coded](https://x.com/karpathy/status/1886192184808149383) in a single session. It is a proof of concept and not intended for production use.

## Requirements

- macOS 11.0 or later
- Swift 5.5 or later
- Xcode 13 or later (for building)
- macOS 12.0 or later (Monterey)

## Setup Instructions

1. Build the application:
   ```
   swift build
   ```

2. Run the application:
   ```
   swift run
   ```

3. Open your web browser and navigate to:
   ```
   http://localhost:8080
   ```

## Permissions

When you first run the application, macOS will ask for permission to access your contacts. You must grant this permission for the app to work.

## Features

- Displays all contacts from your macOS Address Book
- Shows names, organizations, phone numbers, and email addresses
- Simple, clean interface
- No Electron or osascript, purely Swift and web technologies
- Uses Vapor web framework for a robust server implementation
- Runs locally on your machine (doesn't send data anywhere)
