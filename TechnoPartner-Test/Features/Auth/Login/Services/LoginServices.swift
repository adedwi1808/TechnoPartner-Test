//
//  LoginServices.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

protocol LoginServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func doLogin(endpoint: NetworkFactory) async throws -> DoLoginResponseModel
}

final class LoginServices: LoginServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()){
        self.networker = networker
    }
    
    func doLogin(endpoint: NetworkFactory) async throws -> DoLoginResponseModel {
        return try await networker.taskAsync(type: DoLoginResponseModel.self, endPoint: endpoint, isMultipart: false)
    }
    
    
}
