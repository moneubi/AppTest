//
//  DetailUser.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import UIKit

class DetailUserVC: UIViewController {
    
    private var img_user = UIImageView()
    private var email_user = UILabel()
    private var first_name = UITextField()
    private var last_name = UITextField()
    private var btn_cancel = UIButton()
    private var btn_save = UIButton()
    
    let child = SpinnerUtilities()
    
    private let screenSize = UIScreen.main.bounds
    
    var utilisateur: Utilisateur!

    lazy var viewModel = {
        DetailUserViewModel()
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(named: "col_card")
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
        self.title = ""

        self.img_user = ImageUtilities.init().createImageWithURL(x: (screenSize.width - 120)/2, y: 80, width: 120, height: 120, urlImage: "\(utilisateur.avatar ?? "")")
        self.img_user.layer.cornerRadius = 12
        self.img_user.clipsToBounds = true
        self.view.addSubview(self.img_user)
        
        self.email_user = LabelUtilities.init().createLabelView(x: 25, y: 210, width: screenSize.width - 50, height: 30, fontName: "HelveticaNeue", fontSize: 17, textColor: "col_title", numberLine: 1)
        self.view.addSubview(self.email_user)
        self.email_user.text = utilisateur.email
        self.email_user.textAlignment = .center
        
        self.first_name = TextFieldUtilities.init().createTextFieldView(x: 25, y: 300, width: (screenSize.width - 75)/2, height: 46, placeholder: "First Name", borderColor: "col_content")
        self.view.addSubview(self.first_name)
        self.first_name.text = utilisateur.first_name
        
        self.last_name = TextFieldUtilities.init().createTextFieldView(x: (screenSize.width)/2, y: 300, width: (screenSize.width - 75)/2, height: 46, placeholder: "Last Name", borderColor: "col_content")
        self.view.addSubview(self.last_name)
        self.last_name.text = utilisateur.last_name
        
        self.btn_cancel = ButtonUtilities.init().createButtonView(x: 25, y: 380, width: (screenSize.width - 75)/2, height: 56, corner: 10, title: "Cancel", colortitle: "col_accent", colorback: "")
        self.view.addSubview(btn_cancel)
        btn_cancel.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        self.btn_save = ButtonUtilities.init().createButtonView(x: (screenSize.width)/2, y: 380, width: (screenSize.width - 75)/2, height: 56, corner: 10, title: "Save", colortitle: "col_white", colorback: "col_accent")
        self.view.addSubview(btn_save)
        btn_save.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        
        self.view.endEditing(true)
        
        initViewModel()
    }

    @objc func cancel(){
        
        self.view.endEditing(true)
        //self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func initViewModel() {
        
        viewModel.updateLoading = { [weak self] () in
            
            
            DispatchQueue.main.async {
                
                let isUpdated = self?.viewModel.isUpdated ?? false
                
                if isUpdated{
                    
                    self?.child.willMove(toParent: nil)
                    self?.child.view.removeFromSuperview()
                    self?.child.removeFromParent()
                    //self?.navigationController?.dismiss(animated: true)
                }
            }
        }
    }
    
    func goBack(index: Int,first_name: String, last_name: String, avatar: String, id: Int16, email: String){
        
        Common.index_row = index
        Common.first_name = first_name
        Common.last_name = last_name
        Common.avatar = avatar
        Common.id = id
        Common.email = email
        Common.isUpdated.toggle()
        
        //self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveData(){
        
        let id = self.utilisateur.id
        let first_nam = self.first_name.text
        let last_nam = self.last_name.text
        
        self.view.endEditing(true)
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        viewModel.updateUser(id: id, first_name: first_nam ?? "", last_name: last_nam ?? "")
        
        goBack(index: Int(id), first_name: first_nam ?? "", last_name: last_nam ?? "", avatar: self.utilisateur.avatar ?? "" , id: id, email: self.utilisateur.email ?? "")
    }
}
