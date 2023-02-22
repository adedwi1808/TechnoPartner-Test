//
//  UserDefaults.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

extension UserDefaults {
    func getDataFromLocal<T: Codable>(_ type: T.Type, with key: Key, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key.rawValue) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func setDataToLocal<T: Codable>(_ object: T, with key: Key, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key.rawValue)
    }
    
    func resetLocale() {
        for key in Key.allCases {
            self.removeObject(forKey: key.rawValue)
        }
    }
}

extension UserDefaults {
    enum Key: String, CaseIterable {
        case token
        case tokenType
    }
}
