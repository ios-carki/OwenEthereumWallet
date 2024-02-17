//
//  EthereumAdapter.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

import BigInt
import CryptoSwift
import HDWalletKit
import SwiftKeccak


class EthereumAdapter {
    
    class WalletInfo{
        let address: String?
        let privKey: PrivateKey?
        let pubKey: String?
        
        init(address: String?, privKey: PrivateKey?, pubKey: String?) {
            self.address = address
            self.privKey = privKey
            self.pubKey = pubKey
        }
        static func build(mnemonic: String)-> WalletInfo{
            
            let seed = Mnemonic.createSeed(mnemonic: mnemonic)
            let masterKey = PrivateKey(seed: seed, coin: .bitcoin)
            
            //m/44'/60'/0'/0/0
            let purpose = masterKey.derived(at: .hardened(44))
            
            let coinType = purpose.derived(at: .hardened(60))
            
            let account = coinType.derived(at: .hardened(0))
            
            let change = account.derived(at: .notHardened(0))
            
            let privateKey = change.derived(at: .notHardened(0))
            
            let publicKey = privateKey.publicKey.uncompressedPublicKey
            
            let drop = publicKey.dropFirst()
            
            let keccak: Data = keccak256(drop)
            
            let suffix40 = keccak.convertToHexString().suffix(40)
            
            let address = "0x" + suffix40
            print("🔴🔴🔴🔴 ETH Address: ", address)
            
            Constants.ethPrivKey = Data(hex: privateKey.raw.convertToHexString())
            print("저장된 ethPrivKey: ", Constants.ethPrivKey!)
            Constants.ethPubKey = Data(hex: publicKey.convertToHexString())
            print("저장된 ethPubKey: ", Constants.ethPubKey!)
            
            return WalletInfo(address: address, privKey: masterKey, pubKey: publicKey.convertToHexString())
        }
    }
    
    let wallet: WalletInfo?
    
    init(mnemonics: String){
        self.wallet = WalletInfo.build(mnemonic: mnemonics)
        
    }
}
