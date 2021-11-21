//
//  Model.swift
//  Heroes
//
//  Created by Никита Гуляев on 20.11.2021.
//

import Foundation

struct HeroData: Codable {
    let img: String
    var localized_name: String
}

let attributeHero = [
    "Book",
    "Sword",
    "Cloak",
    "Pet",
    "Ax",
    "Shield",
    "Magic",
    "Speed",
    "Flight"
]

    var randomAttribute: Int {
    let randomValue = attributeHero.randomElement()
    return randomValue?.count ?? 0
}
