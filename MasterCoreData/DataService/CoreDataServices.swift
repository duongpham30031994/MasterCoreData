//
//  CoreDataServices.swift
//  MasterCoreData
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import CoreData

class CoreDataServices {
    static let shared: CoreDataServices = CoreDataServices()
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<DataProducts> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<DataProducts> = DataProducts.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "nameProducts", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.context, sectionNameKeyPath: nil, cacheName: "Master")
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    private var _fetchedResultsController: NSFetchedResultsController<DataProducts>?
    
    func saveContext() {
        // Save the context.
        guard let context = _fetchedResultsController?.managedObjectContext else { return }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
