//
//  DataController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 14/04/23.
//

import Foundation
import CoreData

class DataController{
    let persistenceContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext{
        return persistenceContainer.viewContext
    }
    
    init(modelName: String) {
        persistenceContainer = NSPersistentContainer(name: modelName)
    }
    
    func loadData(completion: (() -> Void)? = nil){
        persistenceContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else{
                print("error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            completion?()
        }
    }
}
