//   Created on 2024/02/14
//   Using Swift 5.0
//   AuthMainView.swift
//   Created by Owen
  

import SwiftUI

import Cassette

struct AuthMainView: View {
    weak var navigation: CustomNavigationController?
    @StateObject private var viewModel = AuthMainViewModel()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Spacer()
                
                Image("ETH_Logo")
                    .resizable()
                    .scaledToFit()
                
                BtnCassette(buttonMode: .normal(text: "Access Wallet"))
                    .click {
                        let vc = UIHostingController(rootView: CustomPopupView(mode: .inputPW(password: $viewModel.passwordText), dismissAction: {
                            self.navigation?.dismiss(animated: false)
                        }, confirmAction: {
                            UIApplication.shared.dismissKeyboard()
                            self.navigation?.dismiss(animated: false)
                            
                            UIApplication.shared.createTabBar(index: 0)
                        }))
                        vc.view.backgroundColor = UIColor.clear
                        vc.modalPresentationStyle = .overCurrentContext
                        self.navigation?.present(vc, animated: false)
                    }
                
                Spacer()
                
                BtnCassette(buttonMode: .normal(text: "Create Wallet"))
                    .click {
                        navigation?.pushViewController(UIHostingController(rootView: CreatePasswordView(navigation: navigation)), animated: true)
                    }
                
                BtnCassette(buttonMode: .normal(text: "Import Wallet"))
                    .click {
                        navigation?.pushViewController(UIHostingController(rootView: ImportAccountView(navigation: navigation)), animated: true)
                    }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    AuthMainView()
}
