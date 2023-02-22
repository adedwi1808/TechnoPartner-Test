//
//  MenuViewModel.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var menus = [MenuCategory]()
    @Published var menusCategory = [String]()
    
    @Published var isLoaded: Bool = false
    
    private var menuServices: MenuServicesProtocol
    
    init(menuServices: MenuServicesProtocol = MenuServices()) {
        self.menuServices = menuServices
    }
    
    func getMenusData() async throws {
        do {
            let res = try await menuServices.getMenusData(endpoint: .getMenusData)
            DispatchQueue.main.async {
                self.isLoaded = true
                self.menus = res.result.categories
                for category in res.result.categories {
                    self.menusCategory.append(category.categoryName)
                }
            }
        } catch let err as NetworkError {
            print(err.localizedDescription)
        }
    }
}
