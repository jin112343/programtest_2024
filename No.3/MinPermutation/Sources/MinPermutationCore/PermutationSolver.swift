//
//  PermutationSolver.swift
//  MinPermutation
//
//  Created by mizoi.jin on 2024/11/21.
//


import Foundation

/// 最小順列を計算するコアロジッククラス
public final class MinPermutationCore {
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
            throw MinPermutationError.nonNumericInput // 入力がない場合のエラー
        }
        
        // 入力の長さが条件を満たしているか確認
        guard input.count >= 1, input.count <= 100 else {
            throw MinPermutationError.outOfRangeInput // 範囲外の場合のエラー
        }
        
        // 数値のみで構成されているか確認
        guard input.allSatisfy(\.isNumber) else {
            throw MinPermutationError.nonNumericInput // 数値以外の入力
        }
        
        // 先頭が0でないことを確認
        guard input.first != "0" else {
            throw MinPermutationError.leadingZero // 先頭が0の場合のエラー
        }
        
        // 最小順列を計算して出力
        let sortedDigits = input.sorted()
        guard let firstNonZeroIndex = sortedDigits.firstIndex(where: { $0 != "0" }) else {
            throw MinPermutationError.invalidInput // 不正な入力
        }
        
        var digits = sortedDigits
        digits.swapAt(0, firstNonZeroIndex)
        print(String(digits)) // 結果を出力
    }
}

/// エラー定義
public extension MinPermutationCore {
    enum MinPermutationError: Error {
        case nonNumericInput      // 数値ではない
        case outOfRangeInput      // 範囲外（1未満または100超過）
        case leadingZero         // 先頭が0
        case invalidInput        // その他の不正な入力
    }
}
