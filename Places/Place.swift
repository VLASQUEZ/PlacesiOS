//
//  Place.swift
//  Places
//
//  Created by Andres Velasquez on 5/12/17.
//  Copyright © 2017 Andres Velasquez. All rights reserved.
//

import Foundation
import UIKit

class Place {
    var name = ""
    var type = ""
    var location = ""
    var image : UIImage!
    var rating = "rating"
    var phone = ""
    var website = ""
    init (name : String, type : String , location : String, image : UIImage, phone : String, website : String){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.website = website
    }
}
