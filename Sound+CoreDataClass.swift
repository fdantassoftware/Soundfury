//
//  Sound+CoreDataClass.swift
//  Soundfury
//
//  Created by Fabio Dantas on 26/10/2016.
//  Copyright © 2016 DantasSoftware. All rights reserved.
//

import Foundation
import CoreData


public class Sound: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }

}
