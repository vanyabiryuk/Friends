//
//  DataController.swift
//  Friends
//
//  Created by Vanüsha on 20.07.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Friends")
    
    init() {
        container.loadPersistentStores { _, error in
            if let safeError = error {
                print("Core data failed to load: \(safeError.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}
