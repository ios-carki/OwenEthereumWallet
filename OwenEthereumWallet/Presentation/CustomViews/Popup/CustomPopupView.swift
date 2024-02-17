//
//  CustomPopupView.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import SwiftUI

import Cassette

enum PopupStyle {
    case mnemonicCheck
    case inputPW(password: Binding<String>)
}

struct CustomPopupView: View {
    var mode: PopupStyle
    var dismissAction: () -> ()
    var action : () -> ()
    
    var passwordText: Binding<String> = .constant("")
    @State var passwordError: Binding<Bool> = .constant(false)
    @State var passwordErrorText: Binding<String> = .constant("")
    
    init(mode: PopupStyle, dismissAction: @escaping () -> (), confirmAction: @escaping () -> ()) {
        self.mode = mode
        
        switch self.mode {
        case .mnemonicCheck:
            self.dismissAction = dismissAction
            self.action = confirmAction
        case .inputPW(let password):
            self.passwordText = password
            self.dismissAction = dismissAction
            self.action = confirmAction
        }
    }
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.7).ignoresSafeArea().onTapGesture {
//                action()
                print("빈공간 눌림")
                dismissAction()
            }
            
            VStack(spacing: 12) {
                switch mode {
                case .mnemonicCheck:
                    mnemonicCheck
                case .inputPW:
                    inputPW
                }
                
                HStack(spacing: 12) {
                    BtnCassette(buttonMode: .normal(text: "Cancel"))
                        .setTitleTextColor(color: .gray)
                        .setBackgroundColor(color: .gray.opacity(0.5))
                        .setBorderColor(color: .clear)
                        .setCornerRadius(8)
                        .setButtonHeight(height: 43)
                        .click {
                            dismissAction()
                        }
                    BtnCassette(buttonMode: .normal(text: "Ok"))
                        .setCornerRadius(8)
                        .setBorderColor(color: .blue)
                        .setButtonHeight(height: 43)
                        .click {
                            switch self.mode {
                            case .mnemonicCheck:
                                action()
                            case .inputPW:
                                checkPassword { result in
                                    if result {
                                        action()
                                    }
                                }
                            }
                        }
                }
                .padding(.top, 16)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 3)
            )
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal, 16)
        }
    }
    
    var mnemonicCheck: some View {
        ZStack{
            VStack(spacing: 12){
                Text("You saved it, right?")
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Text("Save these 24 words in a secure location and never share them with anyone.")
                    .foregroundColor(.blue.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    var inputPW: some View {
        ZStack {
            VStack(spacing: 8) {
                TextFieldCassette(mode: .secureUnderLine(placeHolder: "Input Password", text: passwordText, secureImageType: .system(color: .black, on: "", off: ""), title: "Password", alignment: .leading))
                    .setTextFieldHeight(46)
                    .setError(isError: passwordError)
                
                if passwordError.wrappedValue {
                    Text(passwordErrorText.wrappedValue)
                }
            }
        }
    }
    
    // MARK: Function
    private func checkPassword(completion: @escaping (Bool)->()) {
        LocalDBManager.checkPassword(password: passwordText.wrappedValue) { result, decrypted, salt in
            if result {
                print("패스워드 검증 확인 decrypted Data: ", decrypted)
                self.passwordErrorText = .constant("")
                self.passwordError = .constant(false)
                completion(true)
            } else {
                print("패스워드 검증 실패")
                self.passwordErrorText = .constant("Password is incorrect.")
                self.passwordError = .constant(true)
                completion(false)
            }
        }
    }
}

#Preview {
    CustomPopupView(mode: .inputPW(password: .constant(""))) {
        
    } confirmAction: {
            
    }
}
