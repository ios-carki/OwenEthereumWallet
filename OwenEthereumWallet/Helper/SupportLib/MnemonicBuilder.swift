//
//  MnemonicBuilder.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation
import HDWalletKit
import CryptoSwift

class MnemonicBuilder {
    static func generateMnemonic() -> String{
        return Mnemonic.create(strength : .hight)
    }
    // Check is mnemonic phrase valid
    public static func isValid(phrase: [String], wordlist: WordList = .english) -> Bool {
        do {
            let _ = try Self.toEntropy(phrase, wordlist: wordlist)
            return true
        } catch {
            return false
        }
    }
    // Mnemonic Phrase -> Entropy Bytes
    public static func toEntropy(_ phrase: [String], wordlist: WordList = .english) throws -> [UInt8] {
        guard phrase.count > 0, phrase.count <= 24, phrase.count % 3 == 0 else {
            throw Error.invalidMnemonic
        }
        var hBits: UInt8 = 0, hBitsCount: UInt8 = 0
        var bytes = [UInt8]()
        bytes.reserveCapacity(Int((Float(phrase.count) * 10.99) / 8) + 1)
        for word in phrase {
            guard let index = wordlist.words.firstIndex(of: word) else {
                throw Error.invalidMnemonic
            }
            let remainderCount = hBitsCount + 3
            bytes.append(hBits + UInt8(index >> remainderCount))
            if remainderCount >= 8 {
                hBitsCount = remainderCount - 8
                bytes.append(UInt8(truncatingIfNeeded: index >> hBitsCount))
            } else {
                hBitsCount = remainderCount
            }
            hBits = UInt8(truncatingIfNeeded: index << (8 - hBitsCount))
        }
        if phrase.count < 24 { bytes.append(hBits) }
        let checksum = bytes.last!
        let entropy: [UInt8] = bytes.dropLast()
        let calculated = try MnemonicBuilder.calculateChecksumBits(entropy)
        guard checksum == (calculated.checksum << (8 - calculated.bits)) else {
            throw Error.invalidMnemonic
        }
        return entropy
    }
    // Calculate checksum
    public static func calculateChecksumBits(_ entropy: [UInt8]) throws -> (checksum: UInt8, bits: Int) {
        guard entropy.count > 0, entropy.count <= 32, entropy.count % 4 == 0 else {
            throw Error.invalidMnemonic
        }
        
        let size = entropy.count / 4 // Calculate checksum size.
        let hash = SHA2(variant: .sha256).calculate(for: entropy)
        return (hash[0] >> (8 - size), size)
    }
    public enum Error: Swift.Error {
        case invalidMnemonic
        case invalidStrengthSize
        case invalidEntropy
    }
}
