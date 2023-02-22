//
//  MenuResponse.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

// MARK: - GetMenuResponse
struct GetMenuResponse: Codable {
    let status: String
    let result: GetMenuResult
}

// MARK: - Result
struct GetMenuResult: Codable {
    let categories: [MenuCategory]
}

// MARK: - Category
struct MenuCategory: Codable, Hashable {
    let categoryName: String
    var menu: [Menu]

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case menu
    }
}

// MARK: - Menu
struct Menu: Codable, Hashable {
    let name, description: String
    let photo: String
    let price: Int
}
