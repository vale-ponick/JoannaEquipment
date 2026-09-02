//
//  joannaRouletteGame.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 01.09.2026.
//

import Foundation

// MARK: - 🟡 MEDIUM 2. 'Joanna Roulette Game: fantastic win'

enum BetType {
    case red
    case black
    case even
    case odd
    case number(value: Int)
}

enum BetResult {
    case win
    case lose
}

struct MoneyStorage {
    var hundredCrownNotes = 4000
    var tenCrownNotes = 0
    let bagLimit = 4000
    let totalLimit = 15820

    var isBagFull: Bool {
        hundredCrownNotes >= bagLimit
    }

    var isTotalFull: Bool {
        hundredCrownNotes + tenCrownNotes >= totalLimit
    }

    mutating func play(bet: BetType, amount: Int, result: BetResult) {
        guard amount >= 5 else {
            print("❌ Минимальная ставка — 5 крон!")
            return
        }

        switch bet {
        case .red, .black, .even, .odd:
            guard tenCrownNotes >= amount else {
                print("❌ Не хватает 10-кроновых для ставки!")
                return
            }
        case .number:
            guard hundredCrownNotes >= amount else {
                print("❌ Не хватает 100-кроновых для ставки!")
                return
            }
        }

        var newHundred = hundredCrownNotes
        var newTen = tenCrownNotes

        switch (bet, result) {
        case (.red, .win), (.black, .win), (.even, .win), (.odd, .win):
            newTen += amount * 2
        case (.red, .lose), (.black, .lose), (.even, .lose), (.odd, .lose):
            newTen = max(0, newTen - amount)
        case (.number, .win):
            newHundred += amount * 35
        case (.number, .lose):
            newHundred = max(0, newHundred - amount)
        }

        if newHundred > bagLimit {
            let extra = newHundred - bagLimit
            newTen += extra
            newHundred = bagLimit
            print("⚠️ Сумка переполнена! 100-кроновые идут в сетку.")
        }

        hundredCrownNotes = newHundred
        tenCrownNotes = newTen
    }
}

// MARK: - Run Simulation

func runCasinoGame() {
    print("🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA")
    print("🟡 MEDIUM: Task 4. 'Joanna Roulette Game: fantastic win'\n")

    var wallet = MoneyStorage()
    print("💰 СТАРТ: 100-кроновые = \(wallet.hundredCrownNotes), 10-кроновые = \(wallet.tenCrownNotes)\n")

    // 1. 20 на 14
    wallet.play(bet: .number(value: 14), amount: 20, result: .win)
    print("📦 20 на 14 → 100: \(wallet.hundredCrownNotes), 10: \(wallet.tenCrownNotes)")

    // 2. Нечётное ×4
    for i in 1...4 {
        let betAmount = 20 * i * 2
        wallet.play(bet: .odd, amount: betAmount, result: .win)
        print("📦 Нечётное \(i) → 100: \(wallet.hundredCrownNotes), 10: \(wallet.tenCrownNotes)")
    }

    print("\n🥔 Десятки уже не влезают в сетку! Можно наполнить мешок из-под картошки!")

    // 3. Слив мелочи
    print("\n🎰 Иоанна пытается избавиться от 10-кроновых...")
    for round in 1...9 {
        guard wallet.tenCrownNotes > 100 else {
            print("🛑 Остановка: 10-кроновых осталось \(wallet.tenCrownNotes) — достаточно для мелких ставок.")
            break
        }
        let halfAmount = wallet.tenCrownNotes / 2
        let finalBet = max(20, halfAmount)

        wallet.play(bet: .red, amount: finalBet, result: .lose)
        print("📉 Слив \(round) (ставка \(finalBet)) → 10-крон осталось: \(wallet.tenCrownNotes)")
    }

    // 4. Одновременные ставки
    print("\n🎰 Одновременные ставки:")
    wallet.play(bet: .black, amount: 20, result: .lose)
    print("   ❌ чёрное (20)")
    wallet.play(bet: .even, amount: 20, result: .lose)
    print("   ❌ чётное (20)")
    wallet.play(bet: .number(value: 4), amount: 20, result: .win)
    print("   ✅ 4 номера (20) → +160")
    print("📦 Итог раунда → 100: \(wallet.hundredCrownNotes), 10: \(wallet.tenCrownNotes)")

    // 5. Переход на крупные
    print("\n🛑 10-КРОНОВЫХ ПОЧТИ НЕТ! Иоанна переходит на 100-кроновые! 💸")

    // 6. Три ставки на число
    for betAmount in [100, 100, 100] {
        wallet.play(bet: .number(value: 8), amount: betAmount, result: .win)
        print("📦 \(betAmount) на 8 → 100: \(wallet.hundredCrownNotes), 10: \(wallet.tenCrownNotes)")
    }

    // 7. Дополнительная ставка 50 на 8
    wallet.play(bet: .number(value: 8), amount: 50, result: .win)
    print("📦 50 на 8 → 100: \(wallet.hundredCrownNotes), 10: \(wallet.tenCrownNotes)")

    // 8. Две незавершённые ставки (592 + 592)
    let totalBefore = wallet.hundredCrownNotes + wallet.tenCrownNotes
    let diff = totalBefore - wallet.totalLimit

    if diff > 0 {
        let half = diff / 2
        let remainder = diff - half
        wallet.tenCrownNotes -= diff
        print("\n🔫 ВЫСТРЕЛЫ! Ставки на \(half) чёрное и \(remainder) чётное не завершены.")
        print("💸 Деньги остаются на столе.")
        print("📉 Потеря \(diff) → 100: \(wallet.hundredCrownNotes), 10: \(wallet.tenCrownNotes)")
    } else {
        print("\n🔫 ВЫСТРЕЛЫ! Игра прервана! Деньги при ней.")
    }

    // ✅ ИТОГ
    let total = wallet.hundredCrownNotes + wallet.tenCrownNotes
    print("\n💰 ИТОГ СИМУЛЯЦИИ:")
    print("👜 Сумка (100-кроновые): \(wallet.hundredCrownNotes) крон")
    print("🕸️ Сетка (100-кроновые + 10-кроновые): \(wallet.tenCrownNotes) крон")
    print("💵 Всего на руках у Иоанны: \(total) крон")

    if wallet.isTotalFull {
        print("💥 Предел в 15 820 крон успешно достигнут! Бандиты забирают Иоанну. 🏁")
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
