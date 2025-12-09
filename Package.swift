// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FHKUtils",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "FHKUtils",
            targets: ["FHKUtils"]
        ),
    ],
    dependencies: [
        // Sin SwiftLint por ahora
    ],
    targets: [
        .target(
            name: "FHKUtils",
            dependencies: [],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .enableUpcomingFeature("ExistentialAny")
            ]
        ),
        .testTarget(
            name: "FHKUtilsTests",
            dependencies: ["FHKUtils"],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
    ]
)
