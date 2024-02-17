//
//  UserDefaults+Extension.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

extension UserDefaults {
    func setSalt(value: String) {
        set(value, forKey: UserDefaultsKeys.salt.rawValue)
    }
    
    func getSalt() -> String? {
        return string(forKey: UserDefaultsKeys.salt.rawValue) ?? nil
    }
    
    func setEncryptedData(value: String) {
        set(value, forKey: UserDefaultsKeys.encryptedData.rawValue)
    }
    
    func getEncryptedData() -> String? {
        return string(forKey: UserDefaultsKeys.encryptedData.rawValue) ?? nil
    }
    
    func setCreateAccount(value: Bool) {
        set(value, forKey: UserDefaultsKeys.createAccount.rawValue)
    }
    
    func getCreateAccount() -> Bool? {
        return bool(forKey: UserDefaultsKeys.createAccount.rawValue)
    }
}
