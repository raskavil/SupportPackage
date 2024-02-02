// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SupportPackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "SupportPackage", targets: ["SupportPackage"]),
        .library(name: "SupportPackageViews", targets: ["SupportPackageViews"])
    ],
    targets: [
        .target(name: "SupportPackage"),
        .target(
            name: "SupportPackageViews",
            resources: [
                .process("Fonts")
            ]
        ),
        .testTarget(name: "SupportPackageTests", dependencies: ["SupportPackage"])
    ]
)
