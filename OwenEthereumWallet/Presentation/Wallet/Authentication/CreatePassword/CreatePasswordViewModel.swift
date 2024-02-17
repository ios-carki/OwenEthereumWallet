//
//  CreatePasswordViewModel.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

import HDWalletKit

final class CreatePasswordViewModel: ObservableObject {
    @Published var passwordText: String = "" { didSet { buttonCheck() } }
    @Published var passwordError: Bool = false
    @Published var passwordErrorText: String = "Please check the correct password format."
    
    @Published var confirmPasswordText: String = "" { didSet { buttonCheck() } }
    @Published var confirmPasswordError: Bool = false
    @Published var confirmPasswordErrorText: String = "The password is incorrect."
    
    @Published var mnemonicKey: String = MnemonicBuilder.generateMnemonic()
    
    @Published var buttonEnable: Bool = true
    
    func buttonCheck() {
        buttonEnable = passwordText.isEmpty || confirmPasswordText.isEmpty || (passwordText != confirmPasswordText)
    }
}
