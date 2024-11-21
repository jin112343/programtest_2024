//
//  OneDimReversi
//  ReversiGame.swift
//
//  Created by mizoi.jin on 2024/11/21.
//
import Foundation

public final class OneDimReversiCore {
   private let arguments: [String]
   
   // 石の色を表す列挙型（黒か白）
   enum Stone {
       case black
       case white
       
       // 石の色を反転させる
       mutating func flip() {
           self = self == .black ? .white : .black
       }
   }
   
   public init(arguments: [String] = CommandLine.arguments) {
       self.arguments = arguments
   }
   
   // メインの処理を実行
   public func run() throws {
       // コマンドライン引数か標準入力から入力を取得
       let input: String
       if arguments.count > 1 {
           input = arguments[1]
       } else if let stdinInput = readLine() {
           input = stdinInput
       } else {
           throw ReversiError.invalidInput
       }
       
       // 入力文字列の長さをチェック
       guard input.count >= 1, input.count <= 1_000_000 else {
           throw ReversiError.invalidLength
       }
       
       // 入力文字列がLとRのみで構成されているかチェック
       guard input.allSatisfy({ $0 == "L" || $0 == "R" }) else {
           throw ReversiError.invalidCharacter
       }
       
       // 初期配置[黒,白]で開始
       var stones: [Stone] = [.black, .white]
       processGame(moves: input, stones: &stones)
       
       // 最終的な黒と白の数を数えて出力
       let blackCount = stones.filter { $0 == .black }.count
       let whiteCount = stones.filter { $0 == .white }.count
       print("\(blackCount) \(whiteCount)")
   }
   
   // 指定された手順でゲームを進行
   private func processGame(moves: String, stones: inout [Stone]) {
       for (moveIndex, move) in moves.enumerated() {
           // 手番によって置く石の色を決定（奇数:黒、偶数:白）
           let currentStone: Stone = moveIndex % 2 == 0 ? .black : .white
           
           // 左端(L)か右端(R)に石を配置
           let placedIndex: Int
           if move == "L" {
               stones.insert(currentStone, at: 0)
               placedIndex = 0
           } else {
               stones.append(currentStone)
               placedIndex = stones.count - 1
           }
           
           // 挟んだ石をひっくり返す
           findAndFlip(in: &stones, from: placedIndex)
       }
   }
   
   // 置いた石から最も近い同じ色の石を探し、間の石をひっくり返す
   private func findAndFlip(in stones: inout [Stone], from index: Int) {
       let currentColor = stones[index]
       
       // 左方向で最初に見つかる同じ色の石を探す
       var leftMatch: Int? = nil
       for i in (0..<index).reversed() {
           if stones[i] == currentColor {
               leftMatch = i
               break
           }
       }
       
       // 右方向で最初に見つかる同じ色の石を探す
       var rightMatch: Int? = nil
       for i in (index + 1)..<stones.count {
           if stones[i] == currentColor {
               rightMatch = i
               break
           }
       }
       
       // 最も近い同じ色の石との間の石をひっくり返す
       if let left = leftMatch, let right = rightMatch {
           let matchIndex = (index - left) < (right - index) ? left : right
           flipBetween(in: &stones, from: index, to: matchIndex)
       } else if let match = leftMatch {
           flipBetween(in: &stones, from: index, to: match)
       } else if let match = rightMatch {
           flipBetween(in: &stones, from: index, to: match)
       }
   }
   
   // 指定された範囲の石をひっくり返す（隣接する場合を除く）
   private func flipBetween(in stones: inout [Stone], from: Int, to: Int) {
       if abs(from - to) <= 1 { return }  // 隣接する場合は何もしない
       let range = from < to ? (from + 1)..<to : (to + 1)..<from
       for i in range {
           stones[i].flip()
       }
   }
}

// エラーの種類を定義
public extension OneDimReversiCore {
   enum ReversiError: Error {
       case invalidInput      // 入力なし
       case invalidLength     // 不正な長さ
       case invalidCharacter  // 不正な文字
   }
}
