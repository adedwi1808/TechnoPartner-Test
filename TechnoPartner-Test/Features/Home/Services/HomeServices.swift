//
//  HomeServices.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

protocol HomeServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getHomeData(endpoint: NetworkFactory) async throws -> GetHomeResponseModel
}


final class HomeServices: HomeServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getHomeData(endpoint: NetworkFactory) async throws -> GetHomeResponseModel {
        return try await networker.taskAsync(type: GetHomeResponseModel.self, endPoint: endpoint, isMultipart: false)
    }    
}
