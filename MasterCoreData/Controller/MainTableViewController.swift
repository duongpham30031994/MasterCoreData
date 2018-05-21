//
//  MainTableViewController.swift
//  MasterCoreData
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    
    let fetchedResultsController = CoreDataServices.shared.fetchedResultsController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    // ShowInfo to tableViewController
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        // Configure the cell...
        let product = fetchedResultsController.object(at: indexPath)
        configureCell(cell, withProduct: product)
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }

    func configureCell(_ cell: MainTableViewCell, withProduct products: DataProducts) {
        cell.img_Product.image = products.imageProducts as? UIImage
        cell.lb_nameProduct.text = products.nameProducts
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // End show to tableViewController
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            let indexPath = tableView.indexPathForSelectedRow!
            let showTableViewController = segue.destination as! ShowTableViewController
            let product = fetchedResultsController.object(at: indexPath)
            showTableViewController.dataProducts = product
        }
    }
    
    
    @IBAction func onClickMenu() {
        NotificationCenter.default.post(name: NotificationKey.menuClick, object: nil)
    }
}

extension MainTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            configureCell(tableView.cellForRow(at: indexPath!) as! MainTableViewCell, withProduct: anObject as! DataProducts)
        case .move:
            configureCell(tableView.cellForRow(at: indexPath!) as! MainTableViewCell, withProduct: anObject as! DataProducts)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

struct NotificationKey {
    static let menuClick = NSNotification.Name.init("menuClick")
}
