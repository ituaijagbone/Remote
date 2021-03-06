//
//  Presentation.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//  
// Presentation Model: A presentation contains Slides

import Foundation

class Presentation {
    var title: String
    var thumbnail: String
    var slideId: String
    
    init(data: NSDictionary) {
        title = data["title"] as! String
        thumbnail = data["thumbnail"] as! String
        slideId = data["id"] as! String // Poor naming fix latter
    }
}
