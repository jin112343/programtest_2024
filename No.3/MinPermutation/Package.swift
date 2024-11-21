// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MinPermutation", // プロジェクト名
    targets: [
        .executableTarget( // 実行可能なターゲット
            name: "MinPermutation",
            dependencies: ["MinPermutationCore"] // Coreモジュールに依存
        ),
        .target( // フレームワークのターゲット
            name: "MinPermutationCore"
        )
    ]
)
