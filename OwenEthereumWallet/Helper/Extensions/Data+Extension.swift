//
//  Data+Extension.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

extension Data {
    func convertToHexString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
