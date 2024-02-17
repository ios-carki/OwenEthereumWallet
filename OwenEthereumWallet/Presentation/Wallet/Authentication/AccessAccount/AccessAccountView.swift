//
//  AccessAccountView.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import SwiftUI

import Cassette

struct AccessAccountView: View {
    var body: some View {
        ZStack {
            VStack {
                BtnCassette(buttonMode: .normal(text: "Access Account"))
            }
        }
    }
}

#Preview {
    AccessAccountView()
}
