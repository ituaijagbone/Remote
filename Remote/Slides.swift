//
//  Slides.swift
//  Remote
//
//  Created by Itua Ijagbone on 9/5/15.
//  Copyright (c) 2015 Itua Ijagbone. All rights reserved.

// Slide model

import UIKit

class Slides {
    var title: String
    var poster: UIImage
    var posterUrl: String
    //var id: Int
    
    init(data: NSDictionary) {
        title = data["title"] as! String
        posterUrl = data["posterUrl"] as! String
        //id = data["id"] as! Int
        poster = UIImage()
    }
}
