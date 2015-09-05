//
//  PresentationManager.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

import Foundation
import Alamofire

class PresentationManager {
    var presentationList: [Presentation] = []
    let session = NSURLSession.sharedSession()
    
    func getPresentionList(onComplete: (results: [Presentation]) -> Void) {
        Alamofire.request(.GET, "").responseJSON{
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