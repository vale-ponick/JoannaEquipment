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
    case unknown // неизвестно
}

struct CipherFragment {
    let text: String
    let type: CipherType
    let isClear: Bool
}
typealias CipherMessage = [Int: CipherFragment]

let joannaMemory: CipherMessage = [
    1: CipherFragment(text: "Everything is 148 from 7, 1202 from B, like Bernard, two and a half meters to the center", type: .coordinate, isClear: false),
    2: CipherFragment(text: "entrance sealed by explosion", type: .state, isClear: true),
    3: CipherFragment(text: "Contact fishmonger Diego", type: .landmark, isClear: true),
    4: CipherFragment(text: "pa dri", type: .unknown, isClear: false)
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
  
// Функция дешифровки с честной проверкой через guard (как в ТЗ)
func decipher(_ message: CipherMessage) -> String {
    var resultWords: [String] = []
    
    // Идем строго по порядку ячеек (от 1 до 4)
    for index in 1...4 {
        // Проверяем: есть ли фрагмент в памяти? Если нет — пишем [пропущено]
        guard let fragment = message[index] else {
            resultWords.append("[пропущено]")
            continue
        }
        resultWords.append(fragment.text)
    }
    
    return resultWords.joined(separator: " ")
}

func runCipher() {
    let deciphered = decipher(joannaMemory)
    print("🔐 Расшифровка: \(deciphered)")

    print("\n📋 Анализ фрагментов:")
    for index in 1...4 {
        guard let fragment = joannaMemory[index] else { continue }
        
        // Красивый перевод типов через switch
        let typeDescription: String
        switch fragment.type {
        case .coordinate: typeDescription = "координата"
        case .landmark:   typeDescription = "ориентир"
        case .state:      typeDescription = "состояние"
        case .unknown:    typeDescription = "неизвестно"
        }
        
        let clearStatus = fragment.isClear ? "✅ понятно" : "❌ непонятно"
        
        // Используем вашу функцию emoji(for:) прямо здесь
        print("\(emoji(for: index)) \"\(fragment.text)\" → \(typeDescription) — \(clearStatus)")
    }
}
/**
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 🔐 Расшифровка: Everything is 148 from 7, 1202 from B, like Bernard, two and a half meters to the center entrance sealed by explosion Contact fishmonger Diego pa dri

 📋 Анализ фрагментов:
 1️⃣ "Everything is 148 from 7, 1202 from B, like Bernard, two and a half meters to the center" → coordinate — ❌ непонятно
 2️⃣ "entrance sealed by explosion" → state — ✅ понятно
 3️⃣ "Contact fishmonger Diego" → landmark — ✅ понятно
 4️⃣ "pa dri" → uncknown — ❌ непонятно
 Program ended with exit code: 0 */
