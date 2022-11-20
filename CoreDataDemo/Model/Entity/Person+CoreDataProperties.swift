//
//  Person+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by GLABBER on 20.11.2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int16
    @NSManaged public var departament: String?
    @NSManaged public var name: String?
    @NSManaged public var person: Comments?

}

extension Person : Identifiable {

}
