//
//  MenuServices.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

protocol MenuServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getMenusData(endpoint: NetworkFactory) async throws -> GetMenuResponse
}

final class MenuServices: MenuServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getMenusData(endpoint: NetworkFactory) async throws -> GetMenuResponse {
        return try await networker.taskAsync(type: GetMenuResponse.self, endPoint: endpoint, isMultipart: false)
    }
}
