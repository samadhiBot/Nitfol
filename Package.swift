// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "Nitfol",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Nitfol",
            targets: ["Nitfol"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "Nitfol",
            dependencies: [],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "NitfolTests",
            dependencies: ["Nitfol"]
        ),
        .executableTarget(
            name: "gloth",
            dependencies: ["Files"]
        ),
    ]
)
