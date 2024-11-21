//
//  DiceRollToolCore.swift
//  DiceRollTool
//
//  Created by mizoi.jin on 2024/11/21.
//

import Foundation

/// コアロジックを担当するクラス
public final class DiceRollToolCore {
    private let arguments: [String] // コマンドライン引数

    /// 初期化時にコマンドライン引数を受け取る
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    /// メイン処理を実行
    public func run() throws {
        // 入力を取得
        let input: String
        if arguments.count > 1 {
            // 引数から入力
            input = arguments[1]
        } else if let stdinInput = readLine() {
            // 標準入力から入力
            input = stdinInput
        } else {
            throw DiceRollError.nonIntegerInput // 入力がない場合のエラー
        }

        // 入力が整数に変換可能か確認
        guard let A = Int(input) else {
            throw DiceRollError.nonIntegerInput // 整数以外の入力
        }

        // 範囲が条件を満たしているか確認
        guard A >= 2, A <= 100000 else {
            throw DiceRollError.outOfRangeInput // 範囲外の場合のエラー
        }

        // スタートとゴールを含む最小サイコロ回数を計算
        let minDiceRolls = ((A - 1) + 5) / 6
        print(minDiceRolls) // 結果を出力
    }
}

/// エラー定義
public extension DiceRollToolCore {
    enum DiceRollError: Error {
        case nonIntegerInput       // 整数ではない
        case outOfRangeInput       // 範囲外（2未満または100000超過）
    }
}
