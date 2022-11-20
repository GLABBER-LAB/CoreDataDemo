//
//  Person+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by GLABBER on 20.11.2022.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)
    }
}
