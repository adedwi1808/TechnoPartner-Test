//
//  NetworkError.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case middlewareError(code: Int, message: String?)
    
    var localizedDescription: String {
        switch self {
            case .middlewareError(_, let message):
                return message ?? ""
        }
    }
}

struct NetworkHandle: Decodable, Error, LocalizedError {
//    let success: Bool
//    let data: NetworkHandleData
    let message: String
    let code: Int
//    let codeName: String
    
    enum CodingKeys: String, CodingKey {
//        case success
//        case data
        case message
        case code
//        case codeName = "code_name"
    }
}

// MARK: - DataClass
struct NetworkHandleData: Decodable {
}
