//
//  TextFieldUtilities.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import UIKit

class TextFieldUtilities{
    
    private let textField = UITextField()
    
    init(){}
    
    func createTextFieldView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, placeholder: String, borderColor: String) -> UITextField{
        
        textField.frame = CGRect(x: x, y: y, width: width, height: height)
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 0.4
        textField.layer.borderColor = UIColor.init(named: "col_content")?.cgColor
        textField.clipsToBounds = true
        textField.setPadding(left: 20.0, right: 20.0)
        
        return textField
    }
}

extension UITextField {
    func setPadding(left: CGFloat, right: CGFloat? = nil) {
        setLeftPadding(left)
        if let rightPadding = right {
            setRightPadding(rightPadding)
        }
    }
    
    private func setLeftPadding(_ padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }

        private func setRightPadding(_ padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
}
