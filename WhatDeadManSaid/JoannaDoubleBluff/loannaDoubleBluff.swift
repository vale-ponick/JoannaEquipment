//
//  loannaDoubleBluff.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 06.09.2026.
//

import Foundation

// MARK: - TS 'Joanna's Double Bluff'

// Step 1. Data models

enum Language {
    case german
    case danish
    case romanGroup // cpainish, franch, italian
    case other // arabian, asiats
}

enum TrapStatus {
    case failed // her bluff failed
    case partialSuccesss // confused, but not completely
    case totalTriumph // The bandits believed Joanna's bluff
}

enum TrapError: Error {
    case irrelevantRegion
}

struct LinguisticTrap { // пер. в англ. 'лингвистическая ловушка'
    var currentStatus: TrapStatus = .failed // start
    var languagesThugsAvoid: [Language] = [] // languages, ​​that bandits avoid
    
    mutating func processBluff(for language: Language, phrase: String) throws -> String {
        
        switch language {
        case .other:
            throw TrapError.irrelevantRegion
            
        case .danish, .romanGroup:
            currentStatus = .partialSuccesss
            languagesThugsAvoid.append(language)
            return "Sie sind verwirrt. Sie vermeiden jetzt diese Sprache."
            
        case .german:
            if phrase.contains("Donnerwetter") {
                currentStatus = .totalTriumph
                languagesThugsAvoid = [.danish, .romanGroup, .other]
                return "Sie haben es geglaubt! Sie sprechen jetzt Deutsch vor mir!"
            } else {
                currentStatus = .failed
                return "Bluff failed. Joanna is in danger!"
            }
        }
    }
}

func runJoannaDoubleBluff() {
    var trap = LinguisticTrap()
    
    do {
        let result = try trap.processBluff(for: .german, phrase: "Donnerwetter! Was ist 'trap'?")
        print("🎭 Result of bluff: \(result)")
    } catch let error as TrapError {
        switch error {
        case .irrelevantRegion:
            print("❌ Joanna dismissed this region as irrelevant.")
        }
    } catch {
        print("Unexpected error: \(error)")
    }
}
/**
 🏆 Итоги этой связки (Ретроспектива 5️⃣ + 6️⃣). Ты прокачала:
 1. Мутирующие методы (mutating) — теперь ты понимаешь, как структуры меняют свои свойства изнутри.
 2. Обработку ошибок (throws / do-catch) — ты научилась разделять «опасный» код и безопасную зону, которая ловит кастомные ошибки.
 3. Защиту функций (return во всех ветках) — ты научилась думать логическими блоками и закрывать все сценарии (Edge Cases).
 */

/*
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 🎭 Result of bluff: Sie haben es geglaubt! Sie sprechen jetzt Deutsch vor mir!
 Program ended with exit code: 0
 */
