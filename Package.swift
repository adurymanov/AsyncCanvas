// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncCanvas",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AsyncCanvas",
            targets: ["AsyncCanvas"]),
    ],
    targets: [
        .target(
            name: "AsyncCanvas"),
        .testTarget(
            name: "AsyncCanvasTests",
            dependencies: ["AsyncCanvas"]),
    ]
)
