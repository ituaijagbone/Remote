//
//  Presentation.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.
//

import Foundation

class Presentation {
    var title: String
    var thumbnail: String
    var slideId: Int
    
    init(data: NSDictionary) {
        title = data["title"] as! String
        thumbnail = data["thumbnail"] as! String
        slideId = data["id"] as! Int
    }
}