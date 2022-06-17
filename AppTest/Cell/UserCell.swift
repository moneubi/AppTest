//
//  UserCell.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    private var viewEnglobe = UIView()
    private var txt_Title = UILabel()
    private var image_user = UIImageView()
    private var descript_user = UILabel()
    
    let screenSize = UIScreen.main.bounds
    
    private var utilisateurModel : UserCellViewModel!
    
    func setUser(utilisateur: UserCellViewModel){
        
        self.utilisateurModel = utilisateur
        self.txt_Title.text = "\(utilisateur.first_name) \(utilisateur.last_name)"
        self.descript_user.text = utilisateur.email
        
        let url = URL(string: "\(utilisateur.avatar)")
        
        self.image_user.sd_setImage(with: url) { (image, error, cache, urls) in
            if (error != nil) {
                self.image_user.image = UIImage(named: "placeholder")
            } else {
                self.image_user.image = image
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.viewEnglobe = ViewUtilities.init().createView(x: 0, y: 0, width: screenSize.width - 20, height: 70, background: "col_card", cornerRadius: 10)
        addSubview(viewEnglobe)
        
        self.image_user = ImageUtilities.init().createSimpleImageUI(x: 0, y: 0, width: 70, height: 70)
        viewEnglobe.addSubview(image_user)
        
        self.txt_Title = LabelUtilities.init().createLabelView(x: 80, y: 5, width: self.bounds.width - 80, height: 35, fontName: "HelveticaNeue-Bold", fontSize: 14.0, textColor: "col_title", numberLine: 2)
        viewEnglobe.addSubview(txt_Title)
        
        self.descript_user = LabelUtilities.init().createLabelView(x: 80, y: 40, width: self.bounds.width - 80, height: 25, fontName: "HelveticaNeue", fontSize: 14.0, textColor: "col_title", numberLine: 3)
        viewEnglobe.addSubview(descript_user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
