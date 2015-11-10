//
//  PresentationManager.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

// Handles Listing of Presentation on ListPresentationViewController

import Foundation
import Alamofire

class PresentationManager {
    var presentationList: [Presentation] = []
    let session = NSURLSession.sharedSession()
    
    /**
        Get PresentationList from server using Alamofire. 
        - onComplete: Update presentation list in ListPresentationController for display
    */
    func getPresentationList(onComplete: (results: [Presentation]) -> Void) {
        Alamofire.request(.GET, pennappurl + "presentations").responseJSON{
            (request, response, data, error) -> Void in
            println(error)
            if let tmpData: AnyObject = data {
                for entry in tmpData.valueForKey("results") as! [NSDictionary] {
                    let presentation = Presentation(data: entry)
                    self.presentationList.append(presentation)
                }
                
                onComplete(results: self.presentationList)
            }
        }
    }
    
    /**
        Get PresentationList from server using Alamofire when refresh button is clicked. 
        - onComplete: Update presentation list in ListPresentationController for display
    */
    func getNewPresentationList(onComplete: (results: [Presentation]) -> Void) {
        Alamofire.request(.GET, pennappurl + "presentations").responseJSON{
            (request, response, data, error) -> Void in
            println(error)
            if let tmpData: AnyObject = data {
                for entry in tmpData.valueForKey("results") as! [NSDictionary] {
                    let presentation = Presentation(data: entry)
                    self.presentationList.append(presentation)
                }
                
                onComplete(results: self.presentationList)
            }
        }
    }

    /**
        Dummy function to test presentation of list. 
        - onComplete: Update presentation list in ListPresentationController for display
    */
    func getDummyPresentationList(onComplete: (results: [Presentation]) -> Void) {
        for index in 0..<5 {
            var data = [
                "title": "presentation\(index)",
                "thumbnail": "pin\(index).jpg",
                "id": index
            ]
            let presentation = Presentation(data: data)
            self.presentationList.append(presentation)
        }
        onComplete(results: self.presentationList)
    }
}
