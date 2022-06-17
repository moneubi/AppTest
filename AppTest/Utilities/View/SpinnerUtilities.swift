//
//  SpinnerUtilities.swift
//  AppTest
//
//  Created by MBAYE Libasse on 14/6/2022.
//

import Foundation
import UIKit

class SpinnerUtilities: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        spinner.color = UIColor.init(named: "col_spinner")

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
