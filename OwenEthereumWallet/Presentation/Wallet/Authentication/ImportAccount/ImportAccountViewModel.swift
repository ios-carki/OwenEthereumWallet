//
//  ImportAccountViewModel.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/20/24.
//

import Foundation

final class ImportAccountViewModel: ObservableObject {
    @Published var mnemonicKeyText: String = "" { didSet { buttonCheck() } }
    
    @Published var passwordText: String = "" { didSet { buttonCheck() } }
    @Published var confirmPasswordText: String = "" { didSet { buttonCheck() } }
    
    @Published var buttonEnable: Bool = false
    
    func buttonCheck() {
        buttonEnable = mnemonicKeyText.isEmpty || passwordText.isEmpty || confirmPasswordText.isEmpty || passwordText != confirmPasswordText
    }
}
