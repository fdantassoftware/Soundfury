//
//  Sound+CoreDataProperties.swift
//  Soundfury
//
//  Created by Fabio Dantas on 26/10/2016.
//  Copyright © 2016 DantasSoftware. All rights reserved.
//

import Foundation
import CoreData


extension Sound {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sound> {
        return NSFetchRequest<Sound>(entityName: "Sound");
    }

    @NSManaged public var name: String?
    @NSManaged public var audio: NSData?
    @NSManaged public var created: NSDate?

}
