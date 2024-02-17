//
//  LocalDBManager.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

final class LocalDBManager {
    
    static func checkPassword(password: String, completion: @escaping (Bool, String, Array<UInt8>?) -> ()) {
        let salt = Data(base64Encoded: UserDefaults.standard.getSalt() ?? "")?.bytes ?? []
        let encryptedData = Data(base64Encoded: UserDefaults.standard.getEncryptedData() ?? "")?.bytes ?? []
        
        do {
            let decrypt = EncryptData(salt: salt, encryptedData: encryptedData)
            let decryptedData = try decrypt.decrypt(password: password) ?? []
            
            print(String(bytes: decryptedData, encoding: String.Encoding.utf8) ?? "")
            
            Constants.mnemonic = String(bytes: decryptedData, encoding: String.Encoding.utf8) ?? ""

            completion(true, String(bytes: decryptedData, encoding: .utf8) ?? "", salt)
        } catch {
            completion(false, "", nil)
        }
    }
    
    static func saveMnemonic(password: String, seed: String){
        var salt : Array<UInt8>
        
        if UserDefaults.standard.getSalt() == nil {
            salt = EncryptData.generateRandomSalt()?.bytes ?? []
        } else {
            salt = Data(base64Encoded: UserDefaults.standard.getSalt() ?? "")?.bytes ?? []
        }
        
        do {
            let encrypt = EncryptData(salt: salt, encryptedData: nil)
            let encryptedData = try encrypt.encrypt(password: password, data: seed.bytes)
            
            UserDefaults.standard.setSalt(value: salt.toBase64())
            UserDefaults.standard.setEncryptedData(value: encryptedData.toBase64())
            
            Constants.password = password
            Constants.mnemonic = seed
        } catch {
            print(error)
        }
    }
    
    static func createAccount() {
        UserDefaults.standard.setCreateAccount(value: true)
    }
    
    static func clearAll(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
