//
//  GetHomeResponseModel.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

// MARK: - GetHomeResponse
struct GetHomeResponseModel: Codable {
    let status: String
    let result: GetHomeResponseResult
}

// MARK: - Result
struct GetHomeResponseResult: Codable {
    let greeting, name: String
    let saldo, point: Int
    let qrcode: String
    let banner: [String]
}
