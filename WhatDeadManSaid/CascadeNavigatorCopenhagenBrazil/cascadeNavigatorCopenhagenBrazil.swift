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
enum Ocean {
    case atlantic
    case pasific
    case indian
}

enum Continent {
    case africa
    case southAmerica
}

enum NavigationError { // кастомная матрица ошибок
    case oceanMismatch(reason: String)
    case courseMismatch
    case unknownCountry
}
let joannaCalculations: [Calculation]  = [
    Calculation(source: .watch, note: "flight time ~11 hours", isRelevant: true),
    Calculation(source: .atlas, note: "ocean: Atlantic or Pacific or Indian", isRelevant: true),
    Calculation(source: .calendar, note: "sun position confirms south-west course", isRelevant: true)
    ]
