//
//  DetailUserViewModel.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation

class DetailUserViewModel: ObservableObject{
    
    private var detailUserDataSource : DetailUserDataSourceProtocol
    
    var updateLoading: (() -> Void)?
    let users = Common.utilisateurs
    
    var isUpdated = false{
        
        didSet {
            self.updateLoading?()
        }
    }
    
    func updateUser(id: Int16, first_name: String, last_name: String){
        
        detailUserDataSource.updateUser(id: id, first_name: first_name, last_name: last_name, completion: { success, result, error in
            
            if success{
                
                self.updateList(utilisateur: result, users: Common.utilisateurs)
            }else{
                
                print(error ?? "")
            }
        })
    }
    
    func updateList(utilisateur: Utilisateur, users: [Utilisateur]){
        
        var newArray = users
        for i in 0...newArray.count-1 {
            if newArray[i].id == utilisateur.id {
                let index = i
                newArray.remove(at: index)
                newArray.insert(utilisateur, at: index)
            }
        }
    }
    
    init(detailUserDataSource: DetailUserDataSourceProtocol = DetailUserDataSource()) {
        
        self.detailUserDataSource = detailUserDataSource
    }
}
