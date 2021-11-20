//
//  Model.swift
//  Heroes
//
//  Created by Никита Гуляев on 20.11.2021.
//

import Foundation

struct Heroes: Codable {
    var hero: [HeroData] = []
}

struct HeroData: Codable {
    let img: String
    let localized_name: String
}

