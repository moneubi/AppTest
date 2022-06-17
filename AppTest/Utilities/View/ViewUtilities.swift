//
//  ViewUtilities.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import UIKit

class ViewUtilities{
    
    private let viewEnglobe = UIView()
    
    init(){}
    
    func createView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, background: String, cornerRadius: CGFloat) -> UIView{
        
        viewEnglobe.frame = CGRect(x: x, y: y, width: width, height: height)
        viewEnglobe.backgroundColor = UIColor.init(named: background)
        viewEnglobe.layer.cornerRadius = cornerRadius
        viewEnglobe.clipsToBounds = true
        
        return viewEnglobe
    }
}

