// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CF_SDK_IOS_POC",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CF_SDK_IOS_POC",
            targets: ["CF_SDK_IOS_POC"]),
    ],
    dependencies: [
            .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.1")),
            .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.1.0"),
            .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0")
        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CF_SDK_IOS_POC",
            dependencies: [
                        .target(name: "CFSDK"),
                        .product(name: "Alamofire", package: "Alamofire"),
                        .product(name: "ReactiveSwift", package: "ReactiveSwift"),
                        .product(name: "SwiftyJSON", package: "SwiftyJSON")
                    ]),
        .testTarget(
            name: "CF_SDK_IOS_POCTests",
            dependencies: ["CF_SDK_IOS_POC"]),
        .binaryTarget(
                    name: "CFSDK",
                    path: "./Sources/CFSDK.xcframework")
    ]
)
