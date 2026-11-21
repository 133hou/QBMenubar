// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "QBMenubar",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "QBMenubar", targets: ["QBMenubar"]),
        .executable(name: "QBMenubarWidget", targets: ["QBMenubarWidget"]),
        .library(name: "QBMenubarShared", targets: ["QBMenubarShared"])
    ],
    targets: [
        .target(
            name: "QBMenubarShared",
            path: "Sources/QBMenubarShared"
        ),
        .executableTarget(
            name: "QBMenubar",
            dependencies: ["QBMenubarShared"],
            path: "Sources/QBMenubar"
        ),
        .executableTarget(
            name: "QBMenubarWidget",
            dependencies: ["QBMenubarShared"],
            path: "Sources/QBMenubarWidget"
        ),
        .testTarget(
            name: "QBMenubarTests",
            dependencies: ["QBMenubar", "QBMenubarShared"],
            path: "Tests/QBMenubarTests"
        )
    ]
)
