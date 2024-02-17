//
//  AccessAccountViewModel.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

final class AccessAccountViewModel: ObservableObject {
    @Published var passwordText: String = ""
    @Published var passwordError: Bool = false
    @Published var passwordErrorText: String = ""
    
    func checkPassword(completion: @escaping (Bool) -> ()) {
        LocalDBManager.checkPassword(password: passwordText) { result, decrypted, salt in
            if result {
                print("패스워드 검증 확인 decrypted Data: ", decrypted)
                completion(true)
            } else {
                print("패스워드 검증 실패")
                self.passwordErrorText = "Password is incorrect."
                self.passwordError = true
                completion(false)
            }
        }
    }
}
