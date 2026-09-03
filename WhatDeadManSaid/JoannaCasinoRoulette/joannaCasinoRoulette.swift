//
//  joannaCasinoRoulette.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 02.09.2026.
//

import Foundation

enum RouletteBetType { // MARK: - Модели данных
    case red
    case black
    case odd
    case even
    case number(Int)
}

enum RouletteBetResult {
    case win
    case lose
}

struct RouletteBet {
    let type: RouletteBetType
    let amount: Int
    let result: RouletteBetResult
}

struct Bankroll {
    var hundredCrownNotes: Int
    var tenCrownNotes: Int
    
    var total: Int {
        hundredCrownNotes + tenCrownNotes
    }
}


var round: [RouletteBet] = []
typealias RouletteRound = [RouletteBet]
var scenario: [RouletteRound] = []

// MARK: - Движок

struct RouletteEngine { // логика работы рулетки?
    var wallet: Bankroll   // с англ. 'кошелек: хранение денег'
    let limit: Int // лимит кошелька
    var isVerbose: Bool = true // включить / выключить отчет
    
    mutating func run(_ scenario: [RouletteRound]) {
        var roundNumber = 0
        
        for round in scenario {
            roundNumber += 1

        for bet in round {
            let oldBalance = wallet.total
            
            switch bet.result {
            case .win:
                switch bet.type {
                case .number:
                    wallet.hundredCrownNotes += bet.amount * 35 // сотни ×35
                case .red, .black, .even, .odd:
                    wallet.tenCrownNotes += bet.amount * 2 // десятки ×2
                }
            case .lose:
                switch bet.type {
                case .number:
                    guard wallet.hundredCrownNotes >= bet.amount else { return }
                    wallet.hundredCrownNotes -= bet.amount
                case .red, .black, .even, .odd:
                    guard wallet.tenCrownNotes >= bet.amount else { return }
                    wallet.tenCrownNotes -= bet.amount
                } // десятки списать
            }
            if isVerbose {
                report(round: roundNumber, bet: bet, oldBalance: oldBalance)
            }

            if wallet.total >= limit {
                print("💥 Лимит достигнут!")
                return
            }
        }
    }
}
    func report(round: Int, bet: RouletteBet, oldBalance: Int) {
        let newBalance = wallet.total
        let diff = newBalance - oldBalance
        let sign = diff >= 0 ? "+" : ""

        print("Раунд \(round): ставка \(bet.amount) на \(bet.type) → \(bet.result) (\(sign)\(diff)) → баланс: \(newBalance)")
    }
}
/**
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA
 🟡 MEDIUM: Task 4. 'Joanna Roulette Game: fantastic win'

 💰 СТАРТ: 100-кроновые = 4000, 10-кроновые = 0

 ⚠️ Сумка переполнена! 100-кроновые идут в сетку.
 📦 20 на 14 → 100: 4000, 10: 700
 📦 Нечётное 1 → 100: 4000, 10: 780
 📦 Нечётное 2 → 100: 4000, 10: 940
 📦 Нечётное 3 → 100: 4000, 10: 1180
 📦 Нечётное 4 → 100: 4000, 10: 1500

 🥔 Десятки уже не влезают в сетку! Можно наполнить мешок из-под картошки!

 🎰 Иоанна пытается избавиться от 10-кроновых...
 📉 Слив 1 (ставка 750) → 10-крон осталось: 750
 📉 Слив 2 (ставка 375) → 10-крон осталось: 375
 📉 Слив 3 (ставка 187) → 10-крон осталось: 188
 📉 Слив 4 (ставка 94) → 10-крон осталось: 94
 🛑 Остановка: 10-кроновых осталось 94 — достаточно для мелких ставок.

 🎰 Одновременные ставки:
    ❌ чёрное (20)
    ❌ чётное (20)
 ⚠️ Сумка переполнена! 100-кроновые идут в сетку.
    ✅ 4 номера (20) → +160
 📦 Итог раунда → 100: 4000, 10: 754

 🛑 10-КРОНОВЫХ ПОЧТИ НЕТ! Иоанна переходит на 100-кроновые! 💸
 ⚠️ Сумка переполнена! 100-кроновые идут в сетку.
 📦 100 на 8 → 100: 4000, 10: 4254
 ⚠️ Сумка переполнена! 100-кроновые идут в сетку.
 📦 100 на 8 → 100: 4000, 10: 7754
 ⚠️ Сумка переполнена! 100-кроновые идут в сетку.
 📦 100 на 8 → 100: 4000, 10: 11254
 ⚠️ Сумка переполнена! 100-кроновые идут в сетку.
 📦 50 на 8 → 100: 4000, 10: 13004

 🔫 ВЫСТРЕЛЫ! Ставки на 592 чёрное и 592 чётное не завершены.
 💸 Деньги остаются на столе.
 📉 Потеря 1184 → 100: 4000, 10: 11820

 💰 ИТОГ СИМУЛЯЦИИ:
 👜 Сумка (100-кроновые): 4000 крон
 🕸️ Сетка (100-кроновые + 10-кроновые): 11820 крон
 💵 Всего на руках у Иоанны: 15820 крон
 💥 Предел в 15 820 крон успешно достигнут! Бандиты забирают Иоанну. 🏁
 Program ended with exit code: 0
 */
