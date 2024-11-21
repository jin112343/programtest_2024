# MinPermutation 実装仕様書

## 1. ファイル構成
```
.
├── Package.swift      # 依存関係とターゲット定義
├── Sources/
│   ├── MinPermutation/
│   │   └── main.swift # エントリーポイント
│   └── MinPermutationCore/
│       └── PermutationSolver.swift # コアロジック
└── input.in          # 入力ファイル
```

## 2. 実行方法

### コマンドライン引数
```bash
swift run MinPermutation 201 
# 出力: 102
```

### 標準入力
```bash
echo "201" > input.in
cat input.in | swift run DiceRollTool
# 出力: 102
```

## 3. テストケース

### 正常系
| 入力値 | 期待される出力 | 説明 |
|--------|----------------|------|
| 201     | 102             | 基本ケース |
| 12212122212222     | 11112222222222             | ケース |


### 異常系
| 入力値 | 期待されるエラーメッセージ |
|--------|---------------------------|
| abc    | エラー: 数値のみを入力してください。 |
| 01234  | エラー: 先頭に0は使用できません。 |
| 1234567...（101桁） | エラー: 1〜100桁の整数を入力してください。 |
`


### コアロジック説明

### 入力検証処理
- `if arguments.count > 1`：
  コマンドライン引数が渡されているかを確認
- `input.count >= 1, input.count <= 100`：
  入力文字列の長さが1〜100桁の範囲内か確認
- `input.allSatisfy(\.isNumber)`：
  入力が全て数字で構成されているか確認
- `input.first != "0"`：
  先頭が0でないことを確認

### 計算ロジック
```swift
let sortedDigits = input.sorted()
guard let firstNonZeroIndex = sortedDigits.firstIndex(where: { $0 != "0" }) else {
    throw MinPermutationError.invalidInput
}
var digits = sortedDigits
digits.swapAt(0, firstNonZeroIndex)
```

- `input.sorted()`：
  全ての数字を昇順にソート
- `firstIndex(where: { $0 != "0" })`：
  0以外の最小の数字を探索
- `digits.swapAt(0, firstNonZeroIndex)`：
  先頭と0以外の最小の数字を入れ替え


