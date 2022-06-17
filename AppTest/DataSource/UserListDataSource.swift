//
//  UserListDataSource.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import CoreData

protocol UserListDataSourceProtocol{
    
    func getUtilisateurs(completion: @escaping (_ success: Bool, _ results: Utilisateurs?, _ error: String?) -> ())
}

class UserListDataSource: UserListDataSourceProtocol{
    
    private lazy var persistentContainer = StorageManager.init().persistentContainer
    
    func getUtilisateurs(completion: @escaping (Bool, Utilisateurs?, String?) -> ()) {
        
        self.persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
               if let error = error {
                   print("Unable to Add Persistent Store")
                   print("\(error), \(error.localizedDescription)")

               } else {
                   // Create Fetch Request
                   let fetchRequest: NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
                   
                   self?.persistentContainer.viewContext.perform {
                       do {
                           // Execute Fetch Request
                           let results = try fetchRequest.execute()

                           if results.count > 0{
                               
                               for result in results {
                                   
                                   Common.utilisateurs.append(result)
                               }
                               
                               if Common.utilisateurs.count > 0{
                                   
                                   completion(true, Common.utilisateurs, nil)
                               }else{
                                   
                                   completion(false, nil, "Error: Trying to parse Users to model")
                               }
                           }
                       } catch {
                           print("Unable to Execute Fetch Request, \(error)")
                       }
                   }
               }
           }
    }
}
