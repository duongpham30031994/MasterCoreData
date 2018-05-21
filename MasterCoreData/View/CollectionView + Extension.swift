//
//  CollectionView + Extension.swift
//  MasterCoreData
//
//  Created by Apple on 5/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func layoutCollection(numberOfItem: CGFloat, panding: CGFloat) {
        let widthScreen = UIScreen.main.bounds.width
        let widthItem = (widthScreen - panding * (numberOfItem + 1))/numberOfItem
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthItem, height: widthItem)
        layout.sectionInset = UIEdgeInsets(top: panding, left: panding, bottom: panding, right: panding)
        layout.minimumLineSpacing = panding
        self.collectionViewLayout = layout
        
    }
}
