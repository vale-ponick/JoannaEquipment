//
//  joannaEquipment.swift
//  WhatDeadManSaid
//
//  Created by Валерия Пономарева on 29.08.2026.
//

import Foundation

enum ItemType {
    case book
    case clothing
    case accessory
}

struct Item {
    let name: String
    let type: ItemType
    let description: String
    let isDangerous: Bool
    let isUseful: Bool
    
    var info: String {
        switch  type {
        case .book:
            return "📚 Book: \(name) — \(description)"
        case .clothing:
            return "👗 Clothing: \(name) — \(description)"
        case .accessory:
            return "🧣 Accessory: \(name) — \(description)"
        }
    }
}

func runJoannaEquipment() {
    print("EASY: Task 1. 'Joanna Equipment'")
    
    // MARK: - Перед походом на скачки в Шарлоттенлунд Иоанна собирает вещи. Некоторые из них позже помогут ей сбежать из подземелья замка Шаннон (выигранные деньги на скачках, сумка - сетка, географический атлас мира, акриловый шарф, пластмассовый крючок для вязания). Другие — приведут к похищению: платиновый парик и макияж, из-за которых её спутали с Мадлен — сообщницей банды, и именно её бандиты должны были вывезти из казино.
    
    let items: [Item] = [
        Item(name: "Geography Atlas of the World", type: .book, description: "A hefty, beautifully crafted atlas — a long-awaited dream", isDangerous: false, isUseful: true),
        Item(name: "A white acrylic scarf", type: .accessory, description: "A soft, fluffy white acrylic scarf", isDangerous: false, isUseful: true),
        Item(name: "Plastic crochet hook", type: .accessory, description: "A heavy-duty chunky plastic crochet hook", isDangerous: false, isUseful: true),
        Item(name: "A platinum wig and complementary makeup", type: .accessory, description: "Because of them, Joanna was mistaken for Madeleine", isDangerous: true, isUseful: false)
    ]
    
    let dangerousItems = items.filter { $0.isDangerous }
    let dangerousReport: String = dangerousItems.map { $0.info }.joined(separator: "\n")
    print("⚠️ Because of them, Joanna was mistaken for Madeleine and kidnapped:")
    print("\(dangerousReport)")
    let usefulItems = items.filter { $0.isUseful }
    let usefulReport: String = usefulItems.map { $0.info }.joined(separator: "\n")
    print("🧰 they will help Joanna escape the dungeons of Shannon Castle:")
    print("\n\(usefulReport)")
}
