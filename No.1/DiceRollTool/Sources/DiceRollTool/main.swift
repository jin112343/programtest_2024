//
//  main.swift
//  DiceRollTool
//
//  Created by mizoi.jin on 2024/11/21.
//

import DiceRollToolCore

let tool = DiceRollToolCore()

do {
    try tool.run() // Coreモジュールのロジックを呼び出す
} catch let error as DiceRollToolCore.DiceRollError {
    // DiceRollError の場合は詳細なエラーメッセージを出力
    switch error {
    case .nonIntegerInput:
        print("エラー: 入力が整数ではありません。2以上100000以下の整数を入力してください。")
    case .outOfRangeInput:
        print("エラー: 入力が範囲外です。2以上100000以下の整数を入力してください。")
    }
} catch {
    // その他のエラーが発生した場合
    print("エラー: 不明なエラーが発生しました: \(error)")
}
