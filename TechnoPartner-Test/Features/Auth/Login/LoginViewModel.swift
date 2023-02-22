//
//  LoginViewModel.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLogined: Bool = false
    private var prefs: UserDefaults = UserDefaults()
    
    private var loginServices: LoginServicesProtocol
    
    init(loginServices: LoginServicesProtocol = LoginServices()) {
        self.loginServices = loginServices
    }
    
    func doLogin() async throws {
        do {
            let res = try await loginServices.doLogin(endpoint: .doLogin(username: username, password: password))
            saveLoginResponse(with: res)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLogined = true
            }
        } catch let err as NetworkError {
            print(err.localizedDescription)
        }
    }
    
    func saveLoginResponse(with data: DoLoginResponseModel) {
        prefs.setDataToLocal(data.accessToken, with: .token)
        prefs.setDataToLocal(data.tokenType, with: .tokenType)
    }
}
