//
//  CollectionViewController.swift
//  MasterCoreData
//
//  Created by Apple on 5/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellCollectionView"

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet var collection_View: UICollectionView!
    fileprivate let fetchedResultsController = CoreDataServices.shared.fetchedResultsController
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let cell = sender as? UICollectionViewCell,
//            let indexPath = collectionView?.indexPath(for: cell),
//            let managePageViewController = segue.destination as? ManagePageViewController {
//            managePageViewController.photos = photos
//            managePageViewController.currentIndex = indexPath.row
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.layoutCollection(numberOfItem: 4, panding: 10)
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let product = fetchedResultsController.object(at: indexPath)
        configureCell(cell, withProduct: product)
        return cell
    }
    
    func configureCell(_ cell: CollectionViewCell, withProduct products: DataProducts) {
        cell.img_CollectionViewCell.image = products.imageProducts as? UIImage
    }
}
