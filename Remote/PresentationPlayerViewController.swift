//
//  PresentationPlayerController.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

import UIKit

class PresentationPlayerViewController: UIViewController, SlidesCollectionViewControllerDelegate {
    
    var slidesList: [Slides]!
    var slideIndex = 0
    var currentSlide: Slides!
    let slidesManager = SlidesManager()
    var slideId: Int!
    
    @IBOutlet weak var bkImageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slidesManager.getDummySlidesList(self.slideId){
            results in
            self.slidesList = results
            dispatch_async(dispatch_get_main_queue()) {
                self.currentSlide = self.slidesList[self.slideIndex]
                self.load()
            }
        }
    }
    
    func load(){
        let imagedata = currentSlide.poster
        bkImageView.image = imagedata
        posterImageView.image = imagedata
        progressLabel.text = "\(slideIndex+1)/\(slidesList.count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func next(sender: AnyObject) {
        self.currentSlide = self.getNext()
        load()
    }
    
    @IBAction func prev(sender: AnyObject) {
        self.currentSlide = self.getPrev()
        load()
        
    }
    
    func getNext() -> Slides {
        slideIndex++;
        if(slideIndex > self.slidesList.count - 1){
            slideIndex = 0
        }
        print("Get Next")
        return self.slidesList[slideIndex]
    }
    
    func getPrev() -> Slides {
        slideIndex--;
        if(slideIndex < 0){
            slideIndex = self.slidesList.count - 1
        }
        print("Get Prev")
        return self.slidesList[slideIndex]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "slideCollection" {
            let dvc = segue.destinationViewController as! UINavigationController
            let slideCollection = dvc.topViewController as! SlidesCollectionViewController
            slideCollection.delegate = self
            slideCollection.slidesList = self.slidesList
            slideCollection.currentIndex = self.slideIndex
        }
    }
    
    func indexChanged(index: Int) {
        println(index)
        self.slideIndex = index
        self.currentSlide = self.slidesList[self.slideIndex]
        self.load()
    }
}


