//
//  HomeViewModel.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var greeting: String = ""
    @Published var qrcode: String = ""
    @Published var saldo: Int = 0
    @Published var point: Int = 0
    @Published var banner = [String]()
    
    @Published var index: Int = 0
    @Published var openDetailQR: Bool = false
    @Published var isLoaded: Bool = false
    
    var updateTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {_ in
            if self.index < 2 {
                self.index += 1
            } else {
                self.index = 0
            }
        })
    }
    
    private var pref: UserDefaults = UserDefaults()
    private var homeServices: HomeServicesProtocol
    
    init(homeServices: HomeServicesProtocol = HomeServices()) {
        self.homeServices = homeServices
    }
    
    func getHomeData() async throws {
        do {
            let res = try await homeServices.getHomeData(endpoint: .getHomeData)
            DispatchQueue.main.async {
                self.isLoaded = true
                self.name = res.result.name
                self.greeting = res.result.greeting
                self.qrcode = res.result.qrcode
                self.saldo = res.result.saldo
                self.point = res.result.point
                self.banner = res.result.banner
            }
        } catch let err as NetworkError {
            print(err.localizedDescription)
        }
    }
    
}
