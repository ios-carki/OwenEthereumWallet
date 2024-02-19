//
//  CustomTextEditor.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/20/24.
//

import UIKit
import SwiftUI

struct CustomTextEditor: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.black.cgColor
        
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.backgroundColor = UIColor(Color.white)
        uiView.textColor = UIColor(Color.black)
        uiView.layer.cornerRadius = 6
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>

        init(_ text: Binding<String>) {
            self.text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
}


struct TextViewWithPlaceholder: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.backgroundColor = UIColor(Color.white)
        uiView.textColor = UIColor(Color.black)
        uiView.layer.cornerRadius = 6
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text, placeHolder: placeholder)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var placeHolder: String
        
        init(_ text: Binding<String>, placeHolder: String) {
            self.text = text
            self.placeHolder = placeHolder
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
        
        //In Focus
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == placeHolder {
                textView.text = nil
                textView.textColor = .white
            }
        }
        
        //Out Focus
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = placeHolder
                textView.textColor = .gray
            }
        }
    }
    
}
