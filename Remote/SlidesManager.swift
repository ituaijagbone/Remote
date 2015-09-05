//
//  SlidesManager.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

import UIKit
import Alamofire

class SlidesManager {
    var slidesList: [Slides] = []
    let session = NSURLSession.sharedSession()
    
    // let imagedata = NSData(contentsOfURL: NSURL(string: musicTrack.artworkUrl)!)
//    if let tmpdata = imagedata {
//        bkImageView.image = UIImage(data: tmpdata)
//        posterImageView.image = UIImage(data: tmpdata)
//    }
    
    func getSlidesList(onComplete: (results: [Slides]) -> Void) {
        Alamofire.request(.GET, "").responseJSON{
            (request, response, data, error) -> Void in
            println(error)
            if let tmpData: AnyObject = data {
                for entry in tmpData.valueForKey("results") as! [NSDictionary] {
                    let slides = Slides(data: entry)
                    let posterUrl = entry["posterUrl"] as! String
                    let imagedata = NSData(contentsOfURL: NSURL(string: posterUrl)!)
                    if let tmpdata = imagedata {
                        slides.poster = UIImage(data: tmpdata)!
                    } else {
                        slides.poster = UIImage(contentsOfFile: "defaultposter.png")!
                    }

                    self.slidesList.append(slides)
                }
                
                onComplete(results: self.slidesList)
            }
        }
    }
    
    func getDummySlidesList(onComplete: (results: [Slides]) -> Void) {
        for index in 1...5 {
            var data = [
                "title": "presentation\(index)",
                "thumbnail": ""
            ]
            let slides = Slides(data: data)
            self.slidesList.append(slides)
        }
        onComplete(results: self.slidesList)
    }
}