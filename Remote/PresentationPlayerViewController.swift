//
//  PresentationPlayerController.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

// Presentation Player - moves between slides on click with slide controls

import UIKit

class PresentationPlayerViewController: UIViewController, SlidesCollectionViewControllerDelegate {
    
    var slidesList: [Slides]!
    var slideIndex = 0
    var currentSlide: Slides!
    let slidesManager = SlidesManager()
    var slideId: String!
    var navTitle = "Presentation Title"
    
    @IBOutlet var navItem: UINavigationItem!
    
    
    let socket = SocketIOClient(socketURL: "104.42.124.242:3000")
    
    @IBOutlet weak var bkImageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = navTitle
        self.addHandlers()
        self.socket.connect()
        
//        slidesManager.getDummySlidesList(self.slideId){
//            results in
//            self.slidesList = results
//            dispatch_async(dispatch_get_main_queue()) {
//                self.currentSlide = self.slidesList[self.slideIndex]
//                self.load()
//                self.sendIndexToServer()
//            }
//        }

        // Get slides for this presentation from server
        slidesManager.getSlidesList(self.slideId){
            results in
            self.slidesList = results
            dispatch_async(dispatch_get_main_queue()) {
                println(self.slideIndex)
                self.currentSlide = self.slidesList[self.slideIndex]
                self.load()
                self.changePresentationOnServer(self.slideId)
            }
        }
    }
    
    /**
        load a slide on the screen. 
        Update slide progress on screen
    */
    func load(){
        let imagedata = currentSlide.poster
        bkImageView.image = imagedata
        posterImageView.image = imagedata
        progressLabel.text = "\(slideIndex+1)/\(slidesList.count)"
    }
    
    // Socket.io function
    func addHandlers() {
        self.socket.onAny {println("Got event: \($0.event), with items: \($0.items)")}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
        Change slide to next slide when next button is clicked
        Send update to server. Sync with slide on browser
    */
    @IBAction func next(sender: AnyObject) {
        if let tempCurrentSlide = self.getNext() {
            self.currentSlide = tempCurrentSlide
            load()
            self.sendIndexToServer()
        }
    }
    
    /**
        Change slide to prev slide when prev button is clicked
        Send update to server. Sync with slide on browser
    */
    @IBAction func prev(sender: AnyObject) {
        if let tempCurrentSlide = self.getPrev() {
            self.currentSlide = tempCurrentSlide
            load()
            self.sendIndexToServer()
        }
    }
    
//    func getNext() -> Slides {
//        slideIndex++;
//        if(slideIndex > self.slidesList.count - 1){
//            slideIndex = 0
//        }
//        print("Get Next")
//        return self.slidesList[slideIndex]
//    }
    
    /**
        Get the next Slide object from list of slides
        - return: next slide if it exist else nil
    */
    func getNext() -> Slides? {
        if(slideIndex + 1 > self.slidesList.count - 1){
            return nil
        }
        slideIndex++;
        print("Get Next")
        return self.slidesList[slideIndex]
    }
    
//    func getPrev() -> Slides {
//        slideIndex--;
//        if(slideIndex < 0){
//            slideIndex = self.slidesList.count - 1
//        }
//        print("Get Prev")
//        return self.slidesList[slideIndex]
//    }
    
    /**
        Get the prev Slide object from list of slides
        - return: prev slide if it exist else nil
    */
    func getPrev() -> Slides? {
        if(slideIndex - 1 < 0){
            return nil
        }
        slideIndex--;
        print("Get Prev")
        return self.slidesList[slideIndex]
    }
    
    // socket.io to change presentation on server
    func changePresentationOnServer(presentationId: String) {
        self.socket.emit("changePresentation", "\(presentationId)")
    }
    
    // socket.io to change slide index on server
    func sendIndexToServer() {
        self.socket.emit("changeIndex", "\(slideIndex)")
    }
    
    // socket.io to return to home page on server
    func returnToWelcome() {
        self.socket.emit("changeBack", "welcome.jpg")
    }
    
    /**
        Transition to listing of slide in thumbnails
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "slideCollection" {
            let dvc = segue.destinationViewController as! UINavigationController
            let slideCollection = dvc.topViewController as! SlidesCollectionViewController
            slideCollection.delegate = self
            slideCollection.slidesList = self.slidesList
            slideCollection.currentIndex = self.slideIndex
        }
    }
    
    /**
        Update current slide
        load screen to display new slide
        send update to server for sync with browser
    */
    func indexChanged(index: Int) {
        self.slideIndex = index
        self.currentSlide = self.slidesList[self.slideIndex]
        self.load()
        self.sendIndexToServer()
    }
    
    // Tell server to return to home page when user hits back button on phone
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
          self.returnToWelcome()  
        }
    }
}


