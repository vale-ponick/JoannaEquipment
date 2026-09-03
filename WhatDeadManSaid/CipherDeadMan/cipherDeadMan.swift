//
//  cipherDeadMan.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 03.09.2026.
// 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ 0️⃣

import Foundation

//MARK: - 📋 ТЗ: 'Cipher Dead Man' Иоанна вспоминает обрывки фразы. Нужно собрать их в одну строку, сохранив порядок, и уяснить, что понятно Иоанне, а что нет.

/**
 "Все сложено сто сорок восемь от семи, тысяча двести два от "Б", как Бернард, два с половиной метра до центра". Так, что ещё? Ага, «вход закрыт взрывом». Нет, что-то ещё было. «Связь торговец рыбой Диего» и  «па дри».
 */

enum CipherType {
    case coordinate // координаты сокровищ
    case landmark // ориентир
    case state // состояние
    case uncknown // неизвестно
}

struct CipherFragment {
    let position: String
    let text: String
    let type: CipherType
    let isClear: Bool
}
typealias CipherMessage = [Int: CipherFragment]

let joannaMemory: CipherMessage = [
    1: CipherFragment(position: "1️⃣", text: "Everything is 148 from 7, 1202 from B, like Bernard, two and a half meters to the center", type: .coordinate, isClear: false),
    2: CipherFragment(position: "2️⃣", text: "entrance sealed by explosion", type: .state, isClear: true),
    3: CipherFragment(position: "3️⃣", text: "Contact fishmonger Diego", type: .landmark, isClear: true),
    4: CipherFragment(position: "4️⃣", text: "pa dri", type: .uncknown, isClear: false)
]

func emoji(for position: Int) -> String {
    switch position {
    case 1: return "1️⃣"
    case 2: return "2️⃣"
    case 3: return "3️⃣"
    case 4: return "4️⃣"
    case 5: return "5️⃣"
    case 6: return "6️⃣"
    case 7: return "7️⃣"
    case 8: return "8️⃣"
    case 9: return "9️⃣"
    default: return "🔢"
    }
}
  
func decipher(_ message: CipherMessage) -> String {
    let sorted = message.sorted { $0.key < $1.key }
    let result = sorted.map { $0.value.text }.joined(separator: " ")
    return result
}

func runCipher() {
    // 1. Расшифровка
    let deciphered = decipher(joannaMemory)
    print("🔐 Расшифровка: \(deciphered)")

    // 2. Анализ фрагментов
    print("\n📋 Анализ фрагментов:")
    for (key, fragment) in joannaMemory.sorted(by: { $0.key < $1.key }) {
        let clearStatus = fragment.isClear ? "✅ понятно" : "❌ непонятно"
        print("\(emoji(for: key)) \"\(fragment.text)\" → \(fragment.type) — \(clearStatus)")
    }
}
