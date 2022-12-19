// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MKSwiftyFormKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MKSwiftyFormKit",
            targets: ["MKSwiftyFormKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "MKSwiftyFormKit",
            dependencies: []),
        .testTarget(
            name: "MKSwiftyFormKitTests",
            dependencies: ["MKSwiftyFormKit"]),
    ]
)
