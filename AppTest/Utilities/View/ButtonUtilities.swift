//
//  ButtonUtilities.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import UIKit

class ButtonUtilities{
    
    private let btn = UIButton()
    
    init(){}
    
    func createButtonView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, corner: CGFloat, title: String, colortitle: String, colorback: String) -> UIButton{
        
        btn.frame = CGRect(x: x, y: y, width: width, height: height)
        btn.layer.cornerRadius = corner
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor.init(named: colorback)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.init(named: colortitle), for: .normal)
        
        return btn
    }
}
