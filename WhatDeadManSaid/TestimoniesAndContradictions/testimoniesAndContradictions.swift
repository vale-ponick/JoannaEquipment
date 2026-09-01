//
//  testimoniesAndContradictions.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 01.09.2026.
//

import Foundation

// MARK: - 🟡 MEDIUM: Task 4. 'Testimonies and Contradictions'

/* Context:
 Inspector Jensen unravels a case involving a growing syndicate and an Interpol raid on a drug den. Witnesses testify. The system must sort the data, check for hidden markers, and produce a clean analytical report.
 */

/**
🧩 КЛЮЧЕВЫЕ ИНЖЕНЕРНЫЕ СВЯЗКИ (ЧТО ЗАКРЕПЛЯЕМ):
Связка 1️⃣ (Типы и контейнеры): Проектирование enum, struct и вычисляемых свойств (computed properties).
Связка 2️⃣ (Безопасность): Работа с безопасным извлечением данных из коллекций.
Связка 3️⃣ (Логика и ветвление): Оператор switch с дополнительными проверками условий внутри кейсов.
Связка 4️⃣ (Коллекции и трансформация): Полный цикл обработки Dictionary: правильная сортировка, фильтрация надежных объектов и трансформация через map.
Связка 5️⃣ (Структурирование): Разделение интерфейса и реализации через protocol и extension.
*/

// MARK: - Step 1. Create data (enum + struct)
enum TestimonyType { // testimony пер. с англ. 'показания свидетеля'
    case truth
    case evasive
    case contradictory
}

protocol Verifiable {
    var isReliable: Bool {
        get // 🛡️ reliability flag
    }
    func verify() -> String  // 🔍 string check verdict
    
}

struct Testimony { //
    let id: String // keys, identifier
    let witness: String // name
    let statement: String // text of testimonies
    let type: TestimonyType
    let hasSyndicateInfo: Bool // ⚠️ Medium marker: Does the witness know the details of the syndicate or drug den's operation?
}

// MARK: - Step 2. Dataset - dictionary

let testimonies: [String: Testimony] = [
    "1": Testimony(id: "1", witness: "Alicia", statement: "base of things, without money, without documents, which were lying in the desk and among which the only thing missing was a passport", type: .truth, hasSyndicateInfo: false),
    "2": Testimony(id: "2", witness: "Bald Shorty", statement: "Without hiding anything, Shorty admitted to the police honestly and openly that he had indeed seen me a week ago and even spoken to me. I struck him as someone content with life, since I had won. How much had I won? Four thousand sixteen crowns. Yes, I had spoken to others, yes, he had seen it himself; there were two guys hanging around, he had often seen me with them before. And that Sunday I had spoken to them too, but what I did next, he doesn't know.", type: .evasive, hasSyndicateInfo: false),
    "3": Testimony(id: "3", witness: "Frenchmen", statement: "With their backs to the wall, the Frenchmen began to wriggle and give contradictory statements: they gave me a lift to the station, they dropped me off in the city center, it was their car, it wasn't their car, it was the car of an acquaintance, it was the car of a stranger. In the end, they were so confused and so clearly trying to hide something.", type: .contradictory, hasSyndicateInfo: true),
    "4": Testimony(id: "4", witness: "Small Fry", statement: "He testified that I spoke with the French for the last time and left with them. He also left and saw us all get into some car, but he doesn't know what happened next. And he's very sorry I'm not here today.", type: .truth, hasSyndicateInfo: true),
    "5": Testimony(id: "5", witness: "Inspector Jensen", statement: "Several more witnesses were questioned: race car regulars usually know each other, and I, a foreigner, was especially conspicuous. We were able to establish who owned the car. It turned out that its owner had been on the police radar for some time", type: .truth, hasSyndicateInfo: true)
]

// MARK: - Step 3. Implementation of logic and extensions

extension Testimony: Verifiable {
    var isReliable: Bool { // 1. реализуй требования протокола по свойству isReliable
        switch type {
        case .truth:
            return true
        case .evasive, .contradictory:
            return false
        }
    }
    
    var blueSquare: String {
        switch id {
        case "1":
            return "1️⃣"
        case "2":
            return "2️⃣"
        case "3":
            return "3️⃣"
        case "4":
            return "4️⃣"
        case "5":
            return "5️⃣"
        case "6":
            return "6️⃣"
        default:
            return "🔐"
        }
    }
    
    func verify() -> String { // реализуй требование протокола по функции verify
        switch type {
        case .truth:
            if hasSyndicateInfo {
                return "🔥 \(witness) reveals the bitter truth about the international syndicate!"
            } else {
                return "✅ \(witness) speaks the pure truth."
            }
        case .evasive:
            return "⚠️ \(witness) answers briefly and avoids the point."
        case .contradictory:
            if hasSyndicateInfo {
                return "🔥 \(witness) The French, cornered, finally told the truth: after the races, I went with them to some den where they played illegal poker and roulette. Arriving at the den, I paid a hefty entrance fee without batting an eyelid, played roulette, and, I think, won. They lost everything and left early, but I, it seems, stayed behind. Where was this den? It was in this old, dilapidated building on Niels Juel Street, by the canal."
            } else {
                return "❌ \(witness) With their backs to the wall, the Frenchmen began to wriggle and give contradictory statements: they gave me a lift to the station, they dropped me off in the city center, it was their car, it wasn't their car, it was the car of an acquaintance, it was the car of a stranger. In the end, they were so confused and so clearly trying to hide something."
            }
        }
    }
}
    
// MARK: - Step 4. Global Wrapper Function
func runTestimonies() {
    print("MEDIUM: Task 4. 'Testimonies and Contradictions'")
    
    // Сортировка словаря по ключам (твоя идеальная строчка!)
    let sortedTestimonies = testimonies.sorted { firstPair, secondPair in
        return firstPair.key < secondPair.key
    }
    
    // -------------------------------------------
    // БЛОК 1: Вывод всех показаний с тегами типов
    print("\n📋 ALL TESTIMONIES:")
    for (id, testimony) in sortedTestimonies {
        
        // 1. Твой switch для красивого тега типа показаний
        var typeTag = ""
        switch testimony.type {
        case .truth:
            typeTag = "✅ TRUTH"
        case .evasive:
            typeTag = "⚠️ EVASIVE"
        case .contradictory:
            typeTag = "❌ CONTRADICTORY"
        }
        
        // 2. Исправленный принт: всё вызывается через точку от объекта testimony
        print("\(testimony.blueSquare) \(testimony.witness): \"\(testimony.statement)\" — \(typeTag)")
    }
    
    // -------------------------------------------
    // БЛОК 2: Аналитическая проверка (вызов метода из extension)
    print("\n🔍 VERIFICATION:")
    for (id, testimony) in sortedTestimonies {
        // Просто вызываем твою умную функцию verify()
        print(testimony.verify())
    }
    
    // -------------------------------------------
    // БЛОК 3: Фильтрация и вывод надежных свидетелей
    print("\n📌 RELIABLE WITNESSES:")
    
    // Фильтруем массив кортежей, явно называя id и testimony (без _)
    let reliableOnly = sortedTestimonies.filter { id, testimony in
        return testimony.isReliable
    }
    
    // Печатаем имена надежных свидетелей через дефис
    for (id, testimony) in reliableOnly {
        print("- \(testimony.witness)")
    }
}
/**
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 MEDIUM: Task 4. 'Testimonies and Contradictions'

 📋 ALL TESTIMONIES:
 1️⃣ Alicia: "base of things, without money, without documents, which were lying in the desk and among which the only thing missing was a passport" — ✅ TRUTH
 2️⃣ Bald Shorty: "Without hiding anything, Shorty admitted to the police honestly and openly that he had indeed seen me a week ago and even spoken to me. I struck him as someone content with life, since I had won. How much had I won? Four thousand sixteen crowns. Yes, I had spoken to others, yes, he had seen it himself; there were two guys hanging around, he had often seen me with them before. And that Sunday I had spoken to them too, but what I did next, he doesn't know." — ⚠️ EVASIVE
 3️⃣ Frenchmen: "With their backs to the wall, the Frenchmen began to wriggle and give contradictory statements: they gave me a lift to the station, they dropped me off in the city center, it was their car, it wasn't their car, it was the car of an acquaintance, it was the car of a stranger. In the end, they were so confused and so clearly trying to hide something." — ❌ CONTRADICTORY
 4️⃣ Small Fry: "He testified that I spoke with the French for the last time and left with them. He also left and saw us all get into some car, but he doesn't know what happened next. And he's very sorry I'm not here today." — ✅ TRUTH
 5️⃣ Inspector Jensen: "Several more witnesses were questioned: race car regulars usually know each other, and I, a foreigner, was especially conspicuous. We were able to establish who owned the car. It turned out that its owner had been on the police radar for some time" — ✅ TRUTH

 🔍 VERIFICATION:
 ✅ Alicia speaks the pure truth.
 ⚠️ Bald Shorty answers briefly and avoids the point.
 🔥 Frenchmen The French, cornered, finally told the truth: after the races, I went with them to some den where they played illegal poker and roulette. Arriving at the den, I paid a hefty entrance fee without batting an eyelid, played roulette, and, I think, won. They lost everything and left early, but I, it seems, stayed behind. Where was this den? It was in this old, dilapidated building on Niels Juel Street, by the canal.
 🔥 Small Fry reveals the bitter truth about the international syndicate!
 🔥 Inspector Jensen reveals the bitter truth about the international syndicate!

 📌 RELIABLE WITNESSES:
 - Alicia
 - Small Fry
 - Inspector Jensen
 */
