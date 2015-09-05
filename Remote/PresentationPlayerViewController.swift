//
//  PresentationPlayerController.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

import UIKit

class PresentationPlayerViewController: UIViewController {
    
    var slidesList: [Slides]!
    var slideIndex = 0
    var currentSlide: Slides!
    
    @IBOutlet weak var bkImageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    func load(){
        let imagedata = currentSlide.poster
        bkImageView.image = imagedata
        posterImageView.image = imagedata
        // TODO: update progress
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
        if(slideIndex > self.slidesList.count){
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
    
}


