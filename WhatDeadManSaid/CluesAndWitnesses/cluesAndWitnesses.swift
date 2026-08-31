//
//  cluesAndWitnesses.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 29.08.2026.
//

import Foundation

// MARK: - Step 1. Define Structures
enum ClueType {
    case person
    case document
    case object
}

struct Clue {
    let name: String
    let type: ClueType
    let description: String
    var isReliable: Bool
    
    var info: String {
        switch type {
        case .document:
            return "📄 Document: \(name) - \(description)"
        case .person:
            return "👤 Witness: \(name) — \(description)"
        case .object:
            return "📦 Object: \(name) - \(description)"
        }
    }
}

// MARK: - Step 2. Create dictionary
let clues: [String: Clue] = [
    "1.": Clue(name: "Alicia", type: .person, description: "best friend", isReliable: true),
    "2.": Clue(name: "Fritz Torkild", type: .person, description: "Fritz Torkild, a Danish colleague and architect", isReliable: true),
    "3.": Clue(name: "letter to Michal", type: .document, description: "The letter consisted mainly of reasonings on the topic of what Florence's chances were to win the upcoming horse race", isReliable: false),
    "4.": Clue(name: "Hair on the hairbrush", type: .object, description: "Long blonde hairs left on the comb in the bathroom — confirm that Joanna was home on Sunday morning before her disappearance", isReliable: false),
    "5.": Clue(name: "Traces of makeup", type: .object, description: "Smudged foundation and mascara stains on a towel in the bathroom — indicate Joanna was getting ready for the races on Sunday morning", isReliable: false),
    "6.": Clue(name: "Housekeeper", type: .person, description: "The housekeeper who saw Joanna leaving home on Sunday morning while she was cleaning the carpet in the hallway — the last known person to see Joanna before her disappearance", isReliable: true)
]

// MARK: - Step 3. Wrapper Function
func runClueAndWitnesses() {
    print("EASY: Task 2. 'Clues and Witnesses'")
    
    // Вместо $0 или _ используем явные имена пар "key, value"
    let reliableClues = clues.filter { key, value in value.isReliable }
    let trueLeadsReport = reliableClues.map { key, value in value.info }.joined(separator: "\n")
    
    let fakeClues = clues.filter { key, value in !value.isReliable }
    let fakeLeadsReport = fakeClues.map { key, value in value.info }.joined(separator: "\n")
    
    print("\n📌 RELIABLE LEADS:")
    print(trueLeadsReport)
    
    print("\n⚠️ FAKE LEADS:")
    print(fakeLeadsReport)
}
/* 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 EASY: Task 2. 'Clues and Witnesses'

 📌 RELIABLE LEADS:
 👤 Witness: Alicia — best friend
 👤 Witness: Fritz Torkild — Fritz Torkild, a Danish colleague and architect
 👤 Witness: Housekeeper — The housekeeper who saw Joanna leaving home on Sunday morning while she was cleaning the carpet in the hallway — the last known person to see Joanna before her disappearance

 ⚠️ FAKE LEADS:
 📦 Object: Traces of makeup - Smudged foundation and mascara stains on a towel in the bathroom — indicate Joanna was getting ready for the races on Sunday morning
 📄 Document: letter to Michal - The letter consisted mainly of reasonings on the topic of what Florence's chances were to win the upcoming horse race
 📦 Object: Hair on the hairbrush - Long blonde hairs left on the comb in the bathroom — confirm that Joanna was home on Sunday morning before her disappearance
 Program ended with exit code: 0
 */

/*
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 EASY: Task 2. 'Clues and Witnesses'

 📌 RELIABLE LEADS:
 👤 Witness: Alicia — best friend
 👤 Witness: Fritz Torkild — Fritz Torkild, a Danish colleague and architect
 👤 Witness: Housekeeper — The housekeeper who saw Joanna leaving home on Sunday morning while she was cleaning the carpet in the hallway — the last known person to see Joanna before her disappearance

 ⚠️ FAKE LEADS:
 📦 Object: Traces of makeup - Smudged foundation and mascara stains on a towel in the bathroom — indicate Joanna was getting ready for the races on Sunday morning
 📄 Document: letter to Michal - The letter consisted mainly of reasonings on the topic of what Florence's chances were to win the upcoming horse race
 📦 Object: Hair on the hairbrush - Long blonde hairs left on the comb in the bathroom — confirm that Joanna was home on Sunday morning before her disappearance
 */
