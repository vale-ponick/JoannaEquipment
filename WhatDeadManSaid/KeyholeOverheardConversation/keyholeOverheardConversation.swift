//
//  keyholeOverheardConversation.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 04.09.2026.
//

import Foundation

// MARK: - 📋 'Keyhole overheard conversation of the Hansers in French'
/**
 🎬' Joanna eavesdrops through the keyhole on the bandits' conversation in French. The conversation comes through as a muffled noise, but individual phrases are quite distinct. If Joanna hears the unintelligible hum, she loses the thread of the conversation. The program should throw an error, interrupt the dialogue recording, and after the phrase "Is she sleeping?" trigger the "Jump on the sofa" logic, where Joanna turns on the "sweet idiot" and remembers the dead man's real code!
*/
enum InterceptionError: Error { // interseption error пер. с англ. 'перехваченная ошибка'
    case unclearNoise // неразборчивый шум, гул голосов
}

enum Speaker {
    case confidentVoice // сердитый, уверенный голос
    case irritatedVoice // раздраженный голос
    case anxiousVoice // тревожный голос
    case noise // неразборчивый гул, шум
}

struct Phrase {
    let text: String
    let speaker: Speaker
    let isClear: Bool
}

let overheardDialogue: [Phrase] = [
    Phrase(text: "we cannot shake up the whole of Europe centimeter by centimeter", speaker: .confidentVoice, isClear: true),
    Phrase(text: "And we can't kill her, we can't do anything to her at all until she tells us", speaker: .irritatedVoice, isClear: true),
    Phrase(text: "... inarticulate noise and hum of voices...", speaker: .noise, isClear: false),
    Phrase(text: "has she woken up?", speaker: .anxiousVoice, isClear: true)
]
func analyzedDialoge(_ phrases: [Phrase]) throws -> String {
    var result: [String] = []
    for phrase in phrases {
            switch phrase.speaker {
            case .confidentVoice:
                result.append("Confident voice: \(phrase.text)")
            case .irritatedVoice:
                result.append("Irritated voice: \(phrase.text)")
            case .anxiousVoice:
                result.append("Anxious voice: \(phrase.text)")
           case .noise:
                throw InterceptionError.unclearNoise
            }
        }
    return result.joined(separator: " ")
}

func runKeyholeOverheardConversation() {
    print("Joanna pressed her ear to the keyhole...")
    
    do {
        let dialogue = try analyzedDialoge(overheardDialogue)
            print("Dialogue: \(dialogue)")
    } catch InterceptionError.unclearNoise {
        print("🔇 Unclear noise!")
        print("With one kangaroo leap, Joanna found herself on the sofa with an idiotic expression on her face")
        print("Joanna remembers what the deceased said: 🔐  'Everything is 148 from 7, 1202 from B, like Bernard, two and a half meters to the center entrance sealed by explosion Contact fishmonger Diego pa dri'.")
    } catch {
        print("Unexpected error: \(error)")
    }
}

/**
 🚨 'WHAT THE DEAD MAN SAID' from JOANNA CHMIELEWSKA: project macOS Command Line Tool
 Joanna pressed her ear to the keyhole...
 🔇 Unclear noise!
 With one kangaroo leap, Joanna found herself on the sofa with an idiotic expression on her face
 Joanna remembers what the deceased said: 🔐  'Everything is 148 from 7, 1202 from B, like Bernard, two and a half meters to the center entrance sealed by explosion Contact fishmonger Diego pa dri'.
 Program ended with exit code: 0
 */
