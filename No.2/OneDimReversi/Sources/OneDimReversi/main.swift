//
//  main.swift
//  OneDimReversi
//
//  Created by mizoi.jin on 2024/11/21.
//
import OneDimReversiCore

let core = OneDimReversiCore()

do {
    try core.run()
} catch let error as OneDimReversiCore.ReversiError {
    switch error {
    case .invalidInput:
        print("エラー: 入力が指定されていません。")
    case .invalidLength:
        print("エラー: 入力の長さが不正です。1以上1,000,000以下である必要があります。")
    case .invalidCharacter:
        print("エラー: 入力にLまたはR以外の文字が含まれています。")
    }
} catch {
    print("エラー: 予期しない問題が発生しました: \(error)")
}
