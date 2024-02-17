//
//  EncryptData.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

import CryptoSwift

final class EncryptData {
    
    // Use 265 bits for the salt
    private static let SALT_SIZE_BYTES = 32
    // Derive 192 bits long encryption key for AES
    private static let KEY_LENGTH_BYTES = 24
    // Number of hashing iterations. The bigger the number the longer it takes to crack the password
    private static let KEY_ITERATION = 16000
    // Integrity check value size (GCM tag)
    //private static let TAG_LENGTH_BIT = 128; -->Throw unknown error  -->  GCM initial value = 16
    // Initial vector size 128 bits
    private static let IV_LENGTH_BYTES = 16
    
    private var salt : Array<UInt8>?
    private var encryptedData : Array<UInt8>?

    init(salt: Array<UInt8>, encryptedData: Array<UInt8>?) {
        self.salt = salt
        self.encryptedData = encryptedData
    }
    
    static func generateRandomBytes(length: Int) -> Data? {
        var keyData = Data(count: length)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, length, $0.baseAddress!)
        }
        if result == errSecSuccess {
            return keyData
        } else {
            print("Problem generating random bytes")
            return nil
        }
    }
    
    static func generateRandomSalt() -> Data? {
        var keyData = Data(count: SALT_SIZE_BYTES)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, SALT_SIZE_BYTES, $0.baseAddress!)
        }
        if result == errSecSuccess {
            return keyData
        } else {
            print("Problem generating random bytes")
            return nil
        }
    }
    
    func encrypt(password: String, data: Array<UInt8>) throws -> Array<UInt8>{
        do{
            let keyDerivation = try PKCS5.PBKDF2(password: password.bytes,
                                                 salt: self.salt ?? [], iterations: EncryptData.KEY_ITERATION,
                                                 keyLength: EncryptData.KEY_LENGTH_BYTES,
                                                 variant: .sha1).calculate()
            let iv = EncryptData.generateRandomBytes(length: EncryptData.IV_LENGTH_BYTES)
            //let gcm = GCM(iv: iv?.bytes ?? [], tagLength: EncryptedData.TAG_LENGTH_BIT, mode: .combined) --> throw unknown error
            let gcm = GCM(iv: iv?.bytes ?? [], mode: .combined)
            let aes = try AES(key: keyDerivation, blockMode: gcm, padding: .noPadding)
            let encryptedText = try aes.encrypt(data)
            self.encryptedData = (iv?.bytes ?? [])+encryptedText
        }
        catch{
            throw error
        }
        return self.encryptedData ?? []
    }
    
    func decrypt(password: String) throws -> Array<UInt8>?{
        if (encryptedData == nil){
            return nil
        }
        var decryptedData : Array<UInt8>?
        do{
            let iv : Array<UInt8>? = Array<UInt8>(self.encryptedData?[0..<EncryptData.IV_LENGTH_BYTES] ?? [])
            let encrypted  : Array<UInt8>? = Array<UInt8>(self.encryptedData?[EncryptData.IV_LENGTH_BYTES..<(encryptedData?.count ?? 0)] ?? [])
            let keyDerivation = try PKCS5.PBKDF2(password: password.bytes,
                                                 salt: self.salt ?? [], iterations: EncryptData.KEY_ITERATION,
                                                 keyLength: EncryptData.KEY_LENGTH_BYTES,
                                                 variant: .sha1).calculate()
            //let gcm = GCM(iv: iv ?? [], tagLength: EncryptedData.TAG_LENGTH_BIT, mode: .combined)
            let gcm = GCM(iv: iv ?? [], mode: .combined)
            let aes = try AES(key: keyDerivation, blockMode: gcm, padding: .noPadding)
            decryptedData = try aes.decrypt(encrypted ?? [])
        }
        catch {
            throw error
        }
        return decryptedData
    }
}
