// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "transitions",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "Transitions", targets: ["Transitions"]),
    ],
    targets: [
        .target(name: "Transitions"),
        .testTarget(name: "TransitionsTests", dependencies: ["Transitions"]),
    ]
)
