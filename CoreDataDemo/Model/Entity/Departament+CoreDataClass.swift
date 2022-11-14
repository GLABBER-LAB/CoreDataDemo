//
//  Departament+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by GLABBER on 13.11.2022.
//
//

import Foundation
import CoreData

@objc(Departament)
public class Departament: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Departament"), insertInto: CoreDataManager.instance.context)
    }
}
