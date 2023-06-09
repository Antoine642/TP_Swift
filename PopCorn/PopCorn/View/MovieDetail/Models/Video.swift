//
//  Video.swift
//  PopCorn
//
//  Created by digital on 05/06/2023.
//

import Foundation

struct Video: Codable {
    let key: String
    let site: String
    
    private enum CodingKeys: String, CodingKey {
        case key
        case site
    }
}
