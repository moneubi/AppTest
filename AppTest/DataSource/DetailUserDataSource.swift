//
//  DetailUserDataSource.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import CoreData

protocol DetailUserDataSourceProtocol{
    
    func updateUser(id: Int16, first_name: String, last_name: String, completion: @escaping (_ success: Bool, _ result: Utilisateur, _ error: String?) -> ())
}

class DetailUserDataSource: DetailUserDataSourceProtocol{
    
    private lazy var persistentContainer = StorageManager.init().persistentContainer
    
    func updateUser(id: Int16, first_name: String, last_name: String, completion: @escaping (Bool, Utilisateur, String?) -> ()) {
        
        self.persistentContainer.loadPersistentStores{ [weak self] persistentStoreDescription, error in
            if let error = error {
                print("Unable to Add Persistent Store")
                print("\(error), \(error.localizedDescription)")

            } else {
                
                let request: NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
                
                request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
                
                do{
                    print("Request : \(request)")
                    
                    let results = try self?.persistentContainer.viewContext.fetch(request)
                    
                    if results?.count != 0 {
                        
                        
                        let user = results?[0]
                        user?.setValue(first_name, forKey: "first_name")
                        user?.setValue(last_name, forKey: "last_name")
                        self?.save()
                        if user != nil{
                            completion(true, user!, nil)
                        }
                    }
                }catch{
                    print("Fetch Failed: \(error)")
                }
            }
        }
    }
    
    func save() {
        if self.persistentContainer.viewContext.hasChanges {
            do {
                try self.persistentContainer.viewContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
}
