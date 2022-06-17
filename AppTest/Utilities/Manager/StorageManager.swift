//
//  StorageManager.swift
//  AppTest
//
//  Created by MBAYE Libasse on 15/6/2022.
//

import Foundation
import CoreData
import UIKit

class StorageManager{
    
    lazy var persistentContainer: NSPersistentContainer = {
           NSPersistentContainer(name: "Utilisateurs")
    }()
    
    
    init() {
    }
    
    func loadPersistance(){
        
        persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
               if let error = error {
                   print("Unable to Add Persistent Store")
                   print("\(error), \(error.localizedDescription)")

               } else {
                   
                   
               }
        }
    }
}
