//
//  SpokenLanguage.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import Foundation

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso_639_1: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso_639_1
        case name
    }
}
