// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "QBMenubar",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "QBMenubar", targets: ["QBMenubar"])
    ],
    targets: [
        .executableTarget(
            name: "QBMenubar",
            path: "Sources/QBMenubar"
        ),
        .testTarget(
            name: "QBMenubarTests",
            dependencies: ["QBMenubar"],
            path: "Tests/QBMenubarTests"
        )
    ]
)
