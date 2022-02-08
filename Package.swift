// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Nitfol",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v5),
    ],
    products: [
        .library(
            name: "Nitfol",
            targets: ["Nitfol"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Nitfol",
            dependencies: [],
            resources: [
                .process("Nitfol.mlmodelc"),
            ]
        ),
        .testTarget(
            name: "NitfolTests",
            dependencies: ["Nitfol"]
        ),
    ]
)
