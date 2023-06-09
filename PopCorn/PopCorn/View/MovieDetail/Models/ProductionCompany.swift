//
//  ProductionCompany.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import Foundation

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
