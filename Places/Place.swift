//
//  Place.swift
//  Places
//
//  Created by Andres Velasquez on 5/12/17.
//  Copyright © 2017 Andres Velasquez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Place : NSManagedObject {
    @NSManaged var name : String
    @NSManaged var type : String
    @NSManaged var location : String
    @NSManaged var image : NSData?
    @NSManaged var rating : String?
    @NSManaged var phone : String?
    @NSManaged var website : String?
}
