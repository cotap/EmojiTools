// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "EmojiTools",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .macOS(.v10_10),
        .watchOS(.v2)
    ],
    products: [
        .library(name: "EmojiTools", targets: ["EmojiTools"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "EmojiTools",
                path: "EmojiTools",
                resources: [.copy("emoji.txt")]),
        .testTarget(
            name: "EmojiToolsTests",
            dependencies: ["EmojiTools"],
            path: "EmojiToolsTests")
    ]
)
