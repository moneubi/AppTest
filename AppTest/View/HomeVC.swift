//
//  ViewController.swift
//  AppTest
//
//  Created by MBAYE Libasse on 14/6/2022.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    private var btnShowList = UIButton()
    private let viewSpinner = UIView()
    private let child = SpinnerUtilities()
    
    private lazy var persistentContainer = StorageManager.init().persistentContainer
    
    lazy var viewModel = {
        HomeViewModel()
    }()
    
    private let screenSize = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnShowList = ButtonUtilities.init().createButtonView(x: (screenSize.width - 150)/2, y: (screenSize.height - 56)/2, width: 150, height: 56, corner: 10, title: "Fetch Data", colortitle: "col_white", colorback: "col_accent")
        self.view.addSubview(btnShowList)
        btnShowList.addTarget(self, action: #selector(fetch), for: .touchUpInside)

        //My spinner
        viewSpinner.frame = CGRect(x: 0, y: 0, width: screenSize
            .width, height: screenSize.height)
        viewSpinner.backgroundColor = .gray.withAlphaComponent(0.6)
        self.view.addSubview(viewSpinner)
        viewSpinner.isHidden = true
    }
    
    @objc func fetch(){
        
        self.persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
               if let error = error {
                   print("Unable to Add Persistent Store")
                   print("\(error), \(error.localizedDescription)")

               } else {
                   
                   let fetchRequest: NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
                   
                   self?.persistentContainer.viewContext.perform {
                       do {
                           // Execute Fetch Request
                           let result = try fetchRequest.execute()

                           if result.count > 0{
                               
                               self?.navigationController?.pushViewController(UserListVC(), animated: true)
                           }else{
                               self?.initViewModel()
                           }

                       } catch {
                           print("Unable to Execute Fetch Request, \(error)")
                       }
                   }
               }
           }
    }

    func initViewModel() {
        self.viewSpinner.isHidden = false
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        viewModel.getUsers()
        
        viewModel.updateLoadingStatus = { [weak self] () in
            
            DispatchQueue.main.async {
                
                let isRetrived = self?.viewModel.isRetrived ?? false
                
                if isRetrived{
                    
                    self?.viewSpinner.isHidden = true
                    self?.hideLoader()
                    self?.navigationController?.pushViewController(UserListVC(), animated: true)
                }
            }
        }
    }
    
    func hideLoader(){
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

}

