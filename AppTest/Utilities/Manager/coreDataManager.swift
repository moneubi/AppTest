//
//  coreDataManager.swift
//  AppTest
//
//  Created by MBAYE Libasse on 17/6/2022.
//

import Foundation
import UIKit
import CoreData

class coreDataManager: StorageManager{
    
    func fetchData() -> [Utilisateur] {
        let request: NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [Utilisateur]()
    }
    
    func updateUser(id: Int16, first_name: String, last_name: String) {
        let request: NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()

        request.predicate = NSPredicate(format: "id = %@",
                                             argumentArray: [first_name, last_name])
        
        do {
            let results = try persistentContainer.viewContext.fetch(request)
            if results.count != 0 {
                let utilisateur = results[0]
                let newValue = (id != 0) ? utilisateur.id+1 : utilisateur.id-1
                if (newValue == 0) {
                    self.remove(objectID: utilisateur.objectID)
                } else {
                    utilisateur.setValue(newValue, forKey: "first_name")
                    utilisateur.setValue(newValue, forKey: "last_name")
                }
            } else {
                _ = self.insert(id: id, first_name: first_name, last_name: last_name)
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        self.save()
    }
    
    func insert(id: Int16, first_name: String, last_name: String ) -> Utilisateur? {
        guard let utilisateur = NSEntityDescription.insertNewObject(forEntityName: "Utilisateur", into: persistentContainer.viewContext) as? Utilisateur else { return nil }
        utilisateur.id = id
        utilisateur.first_name = first_name
        utilisateur.last_name = last_name
        return utilisateur
    }

    func remove( objectID: NSManagedObjectID ) {
        let obj = persistentContainer.viewContext.object(with: objectID)
        persistentContainer.viewContext.delete(obj)
    }

    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
}
