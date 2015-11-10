//
//  SlidesCollectionViewController.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

// display thumbnail for slides like the Powerpoint thumbnail side bar

import UIKit

let reuseIdentifier = "collection"

// Notify the presentation player that slide index has changed
protocol SlidesCollectionViewControllerDelegate {
    func indexChanged(index: Int)
}

class SlidesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var delegate: SlidesCollectionViewControllerDelegate?
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var slidesList: [Slides]!
    var currentIndex: Int!
    
    @IBOutlet var slidesCollectionView: UICollectionView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.layoutIfNeeded()
        let indexPath = NSIndexPath(forRow: currentIndex, inSection: 0)
        self.slidesCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: false)
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
        
        // Slide model
        cell.title.text = self.slidesList[indexPath.row].title
        let imgName = "pin\(indexPath.row).jpg"
        cell.pinImage.image = self.slidesList[indexPath.row].poster
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Tell Presentation to change slide
        delegate?.indexChanged(indexPath.row)
        
        // dismiss this view. Return to presentation player view
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Dismiss this view. Return to presentation player view
    @IBAction func dismissModel(sender: AnyObject) {
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
