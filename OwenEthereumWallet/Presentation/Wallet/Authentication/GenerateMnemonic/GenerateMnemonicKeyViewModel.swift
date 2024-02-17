//
//  GenerateMnemonicKeyViewModel.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

final class GenerateMnemonicKeyViewModel: ObservableObject {
    func saveMnemonic(password: String, seed: String){
        LocalDBManager.saveMnemonic(password: password, seed: seed)
    }
    
    func createAccount() {
        LocalDBManager.createAccount()
    }
}
