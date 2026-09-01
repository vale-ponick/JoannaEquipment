//
//  horseRacingInCharlottenlund.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 31.08.2026.
//

import Foundation

// MARK: - EASY: Task 3. 'Horse Racing in Charlottenlund'

/* Joanna arrives at the Charlottenlund races. She places bets, meets suspicious characters, wins 4,016 kroner, and attracts the attention of bandits. Police interview witnesses to reconstruct her route.*/

// MARK: - Step 1. Define Enum and Structure

enum WitnessRole { // witness c англ. 'свидетели'
    case bettor // bettor с англ. 'игрок на скачках'
    case police
}

struct Witness {
    let name: String
    let role: WitnessRole
    let statement: String // statement с англ. 'заявление, сообщение'
    var isTrustworthy: Bool // 'заслуживает доверия'?
    
    var info: String { // computed property
        switch role {
        case .bettor:
            return "🎩 Bettor: \(name) — \(statement)"
        case .police:
            return "👮 Police: \(name) - \(statement)"
        }
    }
}

// MARK: - Step 2. Create array
let witnesses: [Witness] = [
    Witness(name: "Alicia", role: .police, statement: "best friend of Joanna, reliable witness", isTrustworthy: true),
    Witness(name: "Bald Shorty", role: .bettor, statement: "unreliable, speaks evasively. Saw Joanna at the races, but doesn't know where she went", isTrustworthy: false),
    Witness(name: "Frenchmens", role: .bettor, statement: "gave contradictory statements about the car", isTrustworthy: false),
    Witness(name: "Inspector Jensen", role: .police, statement: "Inspector Jensen — leading the investigation", isTrustworthy: true)
]
// MARK: - Step 3. Wrapper function пер. с англ. 'функция - обертка'
func runRacesWitnesses() {
    print("EASY: Task 3. 'Horse Racing in Charlottenlund'")
    print("\n 📋 ALL WITNESSES:")
    let all = witnesses.map { witness in witness.info }.joined(separator: "\n")
    print(all)
    let trustWorthyWitnesses = witnesses.filter { witness in witness.isTrustworthy }
    
    let trustworthyReport = trustWorthyWitnesses.map { witness in witness.info }.joined(separator: "\n") // Вместо $0 / _ use явные имена "key, value"
    print("\n📌 TRUSTWORTHY WITNESSES:")
      print(trustworthyReport)
    let untrustworthyWitnesses = witnesses.filter { witness in !witness.isTrustworthy }
    let untrustworthyReport = untrustworthyWitnesses.map { witness in witness.info }.joined(separator: "\n")
    print("\n🚨 UNTRUSTWORTHY WITNESSES:")
    print(untrustworthyReport)
}

/* 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 EASY: Task 3. 'Horse Racing in Charlottenlund'

  📋 ALL WITNESSES:
 👮 Police: Alicia - best friend of Joanna, reliable witness
 🎩 Bettor: Bald Shorty — unreliable, speaks evasively. Saw Joanna at the races, but doesn't know where she went
 🎩 Bettor: Frenchmens — gave contradictory statements about the car
 👮 Police: Inspector Jensen - Inspector Jensen — leading the investigation

 📌 TRUSTWORTHY WITNESSES:
 👮 Police: Alicia - best friend of Joanna, reliable witness
 👮 Police: Inspector Jensen - Inspector Jensen — leading the investigation

 🚨 UNTRUSTWORTHY WITNESSES:
 🎩 Bettor: Bald Shorty — unreliable, speaks evasively. Saw Joanna at the races, but doesn't know where she went
 🎩 Bettor: Frenchmens — gave contradictory statements about the car */
