// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "App",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.113.2"),
        .package(url: "https://github.com/pointfreeco/swift-html-vapor", from: "0.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "HtmlVaporSupport", package: "swift-html-vapor"),
            ])
    ]
)
