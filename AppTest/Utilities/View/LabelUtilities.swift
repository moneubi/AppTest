//
//  LabelUtilities.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import UIKit

class LabelUtilities{
    private let lbl_text = UILabel()
    
    init() {}
    
    func createLabelView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, fontName: String, fontSize: CGFloat, textColor: String, numberLine: Int) -> UILabel{
        
        lbl_text.frame = CGRect(x: x, y: y, width: width, height: height)
        lbl_text.font = UIFont.init(name: fontName, size: fontSize)
        lbl_text.textColor = UIColor.init(named: textColor)
        lbl_text.numberOfLines = numberLine
        
        return lbl_text
    }
}

