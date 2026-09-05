//
//  cascadeNavigatorCopenhagenBrazil.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 04.09.2026.
//

import Foundation

// MARK: - 'Cascade Navigator: Copenhagen - Brazil'

/** TS: Joanna woke up on a plane over the ocean. Using three tools—a watch, a world atlas, and a calendar from the Polish House of Books — she gradually narrowed her search from the global to the specific, eliminating false hypotheses through controlled exclusions (throws)") */
enum CalculationSource {
    case watch
    case atlas
    case calendar
}

struct Calculation {
    let source: CalculationSource
    let note: String
    let isRelevant: Bool // полезен ли факт для математ. расчета
}
enum Ocean: CaseIterable {
    case pacific  // 1. Сначала проверит Тихий (выдаст ошибку)
    case indian   // 2. Потом Индийский (выдаст ошибку)
    case atlantic // 3. В конце Атлантический (выдаст успех)
}

enum Continent {
    case africa
    case southAmerica
}

enum NavigationError: Error { // кастомная матрица ошибок
    case oceanMismatch(reason: String)
    case courseMismatch
    case unknownCountry
}
let joannaCalculations: [Calculation]  = [
    Calculation(source: .watch, note: "flight time ~11 hours", isRelevant: true),
    Calculation(source: .atlas, note: "ocean: Atlantic or Pacific or Indian", isRelevant: true),
    Calculation(source: .calendar, note: "sun position confirms south-west course", isRelevant: true)
    ]

func validateOceanByTime(facts: [String], ocean: Ocean) throws {
    switch ocean {
    case .pacific:
        throw NavigationError.oceanMismatch(reason: "To get to the Pacific Ocean you have to fly across Europe and Asia - it's too far!")
    case .indian:
        throw NavigationError.oceanMismatch(reason: "There is still a lot of water to the south of India, between Africa and Australia, but even here you would have to fly across the whole of Europe.")
    case .atlantic:
       return
    }
}

func determineContinentByCourse(facts: [String]) throws -> Continent {
    guard facts.contains(where: { $0.lowercased().contains("south-west") })  else {
        throw NavigationError.courseMismatch
    }
    return .southAmerica
}

func verifyCountryByAtlas(continent: Continent, guess: String) throws -> String {
    guard continent == .southAmerica, guess == "Brazil" else {
        throw NavigationError.unknownCountry
    }
    return "And if land appears beneath us soon, it must be Brazil"
}

func runFlightAnalysis() {
    let cleanFacts = joannaCalculations
        .filter { $0.isRelevant}
        .map { $0.note }
    
    let oceanNames: [Ocean: String] = [
                .pacific: "Тихий океан",
                .indian: "Индийский океан",
                .atlantic: "Атлантический океан"
            ]
    for ocean in Ocean.allCases {
        let name = oceanNames[ocean] ?? "\(ocean)"
              print("🛰️ Проверка гипотезы: \(name)...")
        
        do {
            try validateOceanByTime(facts: cleanFacts, ocean: ocean)
            print("✅ Время полёта совпадает с картой \(ocean) океана.")
            
            print("🧭 Проверяем курс самолёта...")
            let continent = try determineContinentByCourse(facts: cleanFacts)
            
            print("🗺️ Сверяемся с атласом для поиска страны...")
            let finalResult = try verifyCountryByAtlas(continent: continent, guess: "Brazil")
            print("🎉 Результат: \(finalResult)")
            
        } catch NavigationError.oceanMismatch(let reason) {
            print("❌ Ошибка: \(reason)")
        } catch NavigationError.courseMismatch {
            print("❌ Ошибка: Неверное направление движения для этого региона.")
        } catch NavigationError.unknownCountry {
            print("❌ Ошибка: Локация земли не поддается логике.")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
    

/**
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 🛰️ Проверка гипотезы: Тихий океан...
 Reason: To get to the Pacific Ocean you have to fly across Europe and Asia - it's too far!
 Reason: There is still a lot of water to the south of India, between Africa and Australia, but even here you would have to fly across the whole of Europe.
 And if land appears beneath us soon, it must be Brazil
 Program ended with exit code: 0
 */
