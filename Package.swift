// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HotKey",
    products: [
        .library(name: "HotKey", targets: ["HotKey"]),
    ],
    targets: [
        .target(name: "HotKey"),
        .testTarget(name: "HotKeyTests", dependencies: ["HotKey"]),
    ]
)
