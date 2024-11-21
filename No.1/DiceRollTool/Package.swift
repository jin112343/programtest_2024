// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DiceRollTool", // プロジェクト名
    targets: [
        .executableTarget( // 実行可能なターゲット
            name: "DiceRollTool",
            dependencies: ["DiceRollToolCore"] // Coreモジュールに依存
        ),
        .target( // フレームワークのターゲット
            name: "DiceRollToolCore"
        )
    ]
)
