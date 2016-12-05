//
//  StickyHeaderCollectionViewFlowLayout.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class StickyHeaderCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard var superAttributes = super.layoutAttributesForElements(in: rect) else {
            return super.layoutAttributesForElements(in: rect)
        }
        
        let contentOffset = collectionView!.contentOffset
        let missingSections = NSMutableIndexSet()
        
        for layoutAttributes in superAttributes {
            if (layoutAttributes.representedElementCategory == .cell) {
                missingSections.add(layoutAttributes.indexPath.section)
            }
            
            if let representedElementKind = layoutAttributes.representedElementKind {
                if representedElementKind == UICollectionElementKindSectionHeader {
                    missingSections.remove(layoutAttributes.indexPath.section)
                }
            }
        }
        
        for (idx, _) in missingSections.enumerated() {
            let indexPath = NSIndexPath(item: 0, section: idx)
            if let layoutAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath as IndexPath) {
                superAttributes.append(layoutAttributes)
            }
        }
        
        
        for layoutAttributes in superAttributes {
            if let representedElementKind = layoutAttributes.representedElementKind {
                if representedElementKind == UICollectionElementKindSectionHeader {
                    let section = layoutAttributes.indexPath.section
                    let numberOfItemsInSection = collectionView!.numberOfItems(inSection: section)
                    
                    let firstCellIndexPath = NSIndexPath(item: 0, section: section)
                    let lastCellIndexPath = NSIndexPath(item: max(0, (numberOfItemsInSection - 1)), section: section)
                    
                    var firstCellAttributes:UICollectionViewLayoutAttributes
                    var lastCellAttributes:UICollectionViewLayoutAttributes
                    
                    if (self.collectionView!.numberOfItems(inSection: section) > 0) {
                        firstCellAttributes = self.layoutAttributesForItem(at: firstCellIndexPath as IndexPath)!
                        lastCellAttributes = self.layoutAttributesForItem(at: lastCellIndexPath as IndexPath)!
                    } else {
                        firstCellAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: firstCellIndexPath as IndexPath)!
                        lastCellAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionFooter, at: lastCellIndexPath as IndexPath)!
                    }
                    
                    let headerHeight = layoutAttributes.frame.height
                    var origin = layoutAttributes.frame.origin
                    
                    origin.y = min(max(contentOffset.y, (firstCellAttributes.frame.minY
                        - headerHeight)), (lastCellAttributes.frame.maxY - headerHeight))
                    ;
                    
                    layoutAttributes.zIndex = 1024;
                    layoutAttributes.frame = CGRect(origin: origin, size: layoutAttributes.frame.size)
                    
                }
            }
        }
        
        return superAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}



