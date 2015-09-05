//
//  SlidesCollectionViewController.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

import UIKit

let reuseIdentifier = "collection"

protocol SlidesCollectionViewControllerDelegate {
    func indexChanged(index: Int)
}

class SlidesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var delegate: SlidesCollectionViewControllerDelegate?
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var slidesList: [Slides]!
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if slidesList != nil {
            return slidesList.count
        }
        
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SlidesCollectionViewCell
        cell.title.text = self.slidesList[indexPath.row].title
        let imgName = "pin\(indexPath.row).jpg"
        cell.pinImage.image = UIImage(named: imgName)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.indexChanged(indexPath.row)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//      return CGSize(width: 170, height: 300)
//    }
//    
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//      return sectionInsets
//    }
}
