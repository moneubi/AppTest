//
//  UserListViewModel.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import CoreData

class UserListViewModel: ObservableObject{
    
    private var userListDataSource : UserListDataSourceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var utilisateurs = Common.utilisateurs
    
    var userCellViewModels = [UserCellViewModel](){
        
        didSet{
            
            reloadTableView?()
        }
    }
    
    func getUtilisateurs() {
        userListDataSource.getUtilisateurs(completion: { success, model, error in
            
            if success, let utilisateurs = model {
                self.fetchData(utilisateurs: utilisateurs)
            } else {
                print(error!)
            }
        })
    }
        
    func fetchData(utilisateurs: [Utilisateur]) {
        self.utilisateurs = utilisateurs
        var vms = [UserCellViewModel]()
        for utilisateur in utilisateurs {
            vms.append(createCellModel(utilisateur: utilisateur))
        }
        userCellViewModels = vms
    }
    
    func createCellModel(utilisateur: Utilisateur) -> UserCellViewModel {
        
        let id = utilisateur.id
        let avatar = utilisateur.avatar
        let email = utilisateur.email
        let first_name = utilisateur.first_name
        let last_name = utilisateur.last_name
        
        return UserCellViewModel(id: id, avatar: avatar!, email: email!, first_name: first_name!, last_name: last_name!)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> UserCellViewModel {
        
        return userCellViewModels[indexPath.row]
    }
    
    init(userListDataSource: UserListDataSourceProtocol = UserListDataSource()) {
        
        self.userListDataSource = userListDataSource
    }
}
