// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TranscriptCleaner",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "trim", targets: ["Trim"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        .target(name: "TrimCore"),
        .executableTarget(
            name: "Trim",
            dependencies: [
                "TrimCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "TrimTests",
            dependencies: ["Trim"]
        ),
    ]
)
