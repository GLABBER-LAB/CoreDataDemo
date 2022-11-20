//
//  Comments+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by GLABBER on 20.11.2022.
//
//

import Foundation
import CoreData

@objc(Comments)
public class Comments: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Comments"), insertInto: CoreDataManager.instance.context)
    }
}

