//
//  HomeViewModel.swift
//  AppTest
//
//  Created by MBAYE Libasse on 14/6/2022.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject{
    
    private var homeDatasource : HomeDataSourceProtocol
    private var managedObjectContext: NSManagedObjectContext?
    private lazy var persistentContainer = StorageManager.init().persistentContainer
    
    var updateLoadingStatus: (() -> Void)?
    
    var users = Common.users
    var isRetrived = false{
        
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    func getUsers() {
        
        homeDatasource.getUsers(completion: { success, model, error in
            
            if success, let users = model {
                
                self.fetchData(users: users)
            } else {
                print(error!)
            }
        })
    }
    
    func fetchData(users: [User]) {
        self.users = users
        
        // My persistence section
        self.persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
               if let error = error {
                   print("Unable to Add Persistent Store")
                   print("\(error), \(error.localizedDescription)")

               } else {
                   print(persistentStoreDescription.url ?? "")
               }
           }
        self.managedObjectContext = self.persistentContainer.viewContext
            
        guard self.managedObjectContext != nil else {
            fatalError("No Managed Object Context Available")
        }
        
        for user in users {
            
            //Add user by user in Core Data
            addUserInCoreData(user: user)
        }
        self.isRetrived.toggle()
    }
    
    func addUserInCoreData(user: User){
        
        do {
            // Create User
            let use = try Utilisateur(context: managedObjectContext!)

            use.id = Int16(user.id)
            use.avatar = user.avatar
            use.last_name = user.last_name
            use.first_name = user.first_name
            use.email = user.email
            
            // Save User to Persistent Store
            try managedObjectContext?.save()
        } catch {
            print("Unable to Save User, \(error)")
        }
    }
    
    init(homeDatasource: HomeDataSourceProtocol = HomeDataSource()) {
        
        self.homeDatasource = homeDatasource
    }
}
