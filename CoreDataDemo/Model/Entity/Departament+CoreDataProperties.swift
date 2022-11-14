//
//  Departament+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by GLABBER on 13.11.2022.
//
//

import Foundation
import CoreData


extension Departament {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Departament> {
        return NSFetchRequest<Departament>(entityName: "Departament")
    }

    @NSManaged public var nameDep: String?

}

extension Departament : Identifiable {

}
