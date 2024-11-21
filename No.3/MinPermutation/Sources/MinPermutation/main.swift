//
//  main.swift
//  MinPermutation
//
//  Created by mizoi.jin on 2024/11/21.
//

import MinPermutationCore

let core = MinPermutationCore()

do {
    try core.run()
} catch let error as MinPermutationCore.MinPermutationError {
    switch error {
    case .nonNumericInput:
        print("エラー: 数値のみを入力してください。")
    case .outOfRangeInput:
        print("エラー: 1～100桁の整数を入力してください。")
    case .leadingZero:
        print("エラー: 先頭に0は使用できません。")
    case .invalidInput:
        print("エラー: 不正な入力です。")
    }
} catch {
    print("エラー: 予期しない問題が発生しました: \(error.localizedDescription)")
}
