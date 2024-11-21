// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "OneDimReversi",
    targets: [
        .executableTarget(
            name: "OneDimReversi",
            dependencies: ["OneDimReversiCore"]
        ),
        .target(
            name: "OneDimReversiCore"
        )
    ]
)
