//
//  ImportAccountView.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/20/24.
//

import SwiftUI

import Cassette

struct ImportAccountView: View {
    weak var navigation: CustomNavigationController?
    @StateObject private var viewModel = ImportAccountViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("MnemonicKey")
                    Spacer()
                }
                CustomTextEditor(text: $viewModel.mnemonicKeyText)
                    .frame(height: 100)
                
                TextFieldCassette(mode: .secureUnderLine(placeHolder: "Input Password", text: $viewModel.passwordText, secureImageType: .system(color: .black, on: "", off: ""), title: "Password", alignment: .leading))
                    .setRectangleFieldBorderColor(.black)
                    .setTitleTextColor(.black)
                    .padding(.top, 16)
                
                TextFieldCassette(mode: .secureUnderLine(placeHolder: "Input Password", text: $viewModel.confirmPasswordText, secureImageType: .system(color: .black, on: "", off: ""), title: "Confirm Password", alignment: .leading))
                    .setRectangleFieldBorderColor(.black)
                    .setTitleTextColor(.black)
                
                Spacer()
                
                BtnCassette(buttonMode: .normal(text: "Import"))
                    .setBorderColor(color: .black)
                    .setTitleTextColor(color: .black)
                    .setBackgroundColor(color: .black.opacity(0.1))
                    .setDisableBackgroundColor(color: .gray.opacity(0.5))
                    .setDisableTitleTextColor(color: .gray)
                    .setBorderColor(color: .clear)
                    .setDisable(disable: $viewModel.buttonEnable)
                    .click {
                        Constants.password = viewModel.passwordText
                        Constants.mnemonic = viewModel.mnemonicKeyText
                        
                        //초기화면으로
                        navigation?.popToRootViewController(animated: true)
                    }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ImportAccountView()
}
