//
//  DoLoginResponseModel.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

struct DoLoginResponseModel: Codable, Hashable {
    let tokenType: String
    let expiresIn: Int
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
