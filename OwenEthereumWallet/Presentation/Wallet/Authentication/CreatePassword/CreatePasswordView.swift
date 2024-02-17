//
//  CreatePasswordView.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import SwiftUI

import Cassette

struct CreatePasswordView: View {
    weak var navigation: CustomNavigationController?
    @StateObject private var viewModel = CreatePasswordViewModel()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 12) {
                TextFieldCassette(mode: .secureUnderLine(placeHolder: "Input Password", text: $viewModel.passwordText, secureImageType: .system(color: .black, on: "", off: ""), title: "Password", alignment: .leading))
                    .setError(isError: $viewModel.passwordError)
                
                if viewModel.passwordError {
                    Text(viewModel.passwordErrorText)
                }
                
                TextFieldCassette(mode: .secureUnderLine(placeHolder: "Confirm Password", text: $viewModel.confirmPasswordText, secureImageType: .system(color: .black, on: "", off: ""), title: "Confirm Password", alignment: .leading))
                    .setError(isError: $viewModel.confirmPasswordError)
                
                if viewModel.confirmPasswordError {
                    Text(viewModel.confirmPasswordErrorText)
                }
                
                Spacer()
                
                BtnCassette(buttonMode: .normal(text: "Next"))
                    .setDisable(disable: $viewModel.buttonEnable)
                    .setDisableBackgroundColor(color: .gray.opacity(0.5))
                    .setDisableTitleTextColor(color: .gray)
                    .click {
                        navigation?.pushViewController(UIHostingController(rootView: GenerateMnemonicKeyView(navigation: navigation, passwordText: viewModel.passwordText, mnemonicText: viewModel.mnemonicKey)), animated: true)
                    }
                    
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    CreatePasswordView()
}
