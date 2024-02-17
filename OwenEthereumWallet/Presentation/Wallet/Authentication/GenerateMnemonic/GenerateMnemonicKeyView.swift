//
//  GenerateMnemonicKeyView.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import SwiftUI

import Cassette

struct GenerateMnemonicKeyView: View {
    weak var navigation: CustomNavigationController?
    @StateObject private var viewModel = GenerateMnemonicKeyViewModel()
    
    var passwordText: String
    var mnemonicText: String
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("MnemonicKey")
                    .foregroundColor(.black)
                
                VStack {
                    Text(mnemonicText)
                        .foregroundColor(.black)
                }
                .padding(.all, 16)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.blue, lineWidth: 1.5)
                )
                
                BtnCassette(buttonMode: .normal(text: "Copy to clipboard"))
                
                Spacer()
                
                BtnCassette(buttonMode: .normal(text: "Next"))
                    .click {
                        let vc = UIHostingController(rootView: CustomPopupView(mode: .mnemonicCheck, dismissAction: {
                            self.navigation?.dismiss(animated: false)
                        }, confirmAction: {
                            //니모닉 저장
                            viewModel.saveMnemonic(password: passwordText, seed: mnemonicText)
                            
                            //어카운트 생성한 유저인지 아닌지 분기
                            viewModel.createAccount()
                            
                            //팝업 종료
                            self.navigation?.dismiss(animated: false)
                            
                            //초기화면으로
                            navigation?.popToRootViewController(animated: true)
                        }))
                        vc.view.backgroundColor = UIColor.clear
                        vc.modalPresentationStyle = .overCurrentContext
                        self.navigation?.present(vc, animated: false)
                    }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    GenerateMnemonicKeyView(passwordText: "asdf", mnemonicText: "adsf das asdf asd adsf das asdf asd adsf das asdf asd adsf das asdf asd ")
}
