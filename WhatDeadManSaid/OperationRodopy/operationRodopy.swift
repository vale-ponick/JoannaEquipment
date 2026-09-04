//
//  operationRodopy.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 03.09.2026.
//

import Foundation

// MARK: - 📋 «Операция Родопы»🎬
/**
 Иоанна диктует Дьяволу изменённые данные шифра, чтобы запутать мафию. Программа собирает ложную фразу. Но если Дьявол допрашивает её о единицах измерения, код выбрасывает ошибку, а блок do-catch выводит книжный ответ Иоанны.
 */
 /* 🧩 Что тренируем
  6️⃣ Ошибки: enum Error, ключевые слова throws, throw, блоки do-catch.
  3️⃣ Логика: Оператор switch для обработки пойманных ошибок.
  4️⃣ Коллекции: Работа со словарем [Int: FakeFragment].
  🔤 Строки: Методы .lowercased() и .contains(...).
*/

enum CipherError: Error { // кастомные ошибки
    case criticalDataMissing // нужного индекса ент в словаре
    case unknownUnitsOfMeasurement // если Дьявол выпытывает единицы измерения
}

struct FakeFragment {
    let text: String // текст цитаты
    let fragmentType: CipherType
}
let fakeMemory: [Int: FakeFragment] = [
    1: FakeFragment(text: "Everything is stored", fragmentType: .state),
    2: FakeFragment(text: "one hundred and eleven from twenty-nine", fragmentType: .coordinate),
    3: FakeFragment(text: "and one thousand thirty-two from A like Albert", fragmentType: .landmark),
    4: FakeFragment(text: "lowered to a depth of fifteen meters", fragmentType: .state)
]

func generateFakeTrail(_ cipherData: [Int: FakeFragment]) throws -> String {
    var fakes: [String] = []
    
    for index in 1...4 {
        guard let fragment = cipherData[index] else {
            throw CipherError.criticalDataMissing
        }
        fakes.append(fragment.text)
    }
    let result = fakes.joined(separator: " ")
    return result
}

func answerDevil(question: String) throws -> String { // Шаг 5. Защита от допроса
    let question = question.lowercased()
    if question.contains("what") {
        throw CipherError.unknownUnitsOfMeasurement
    } else {
        return "Yes, it is hidden in a crevice or cave."
    }
}

func runFakeCipher() {
    print("Joanna sets a false trail in the Rhodope Mountains...")
    do {
        let trail = try generateFakeTrail(fakeMemory)
        print("🔐 Fake cipher: \(trail)")
        
        let devilQuestion = "One hundred and eleven what?"
        print("👿 Devil: \(devilQuestion)")
        
        let answer = try answerDevil(question: devilQuestion)
        print("🗣️ Joanna: \(answer)")
        
    } catch CipherError.unknownUnitsOfMeasurement {
        print("🗣️ Joanna: How would I know? Maybe meters, maybe feet, or maybe some other units, I have no idea.")
    } catch CipherError.criticalDataMissing {
        print("memory failure - fragment missing!")
    } catch {
        print("Unexpected error: \(error)")
    }
}
/**
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 Joanna sets a false trail in the Rhodope Mountains...
 🔐 Fake cipher: Everything is stored one hundred and eleven from twenty-nine and one thousand thirty-two from A like Albert lowered to a depth of fifteen meters
 👿 Devil: One hundred and eleven what?
 🗣️ Joanna: How would I know? Maybe meters, maybe feet, or maybe some other units, I have no idea.
 */

