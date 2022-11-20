//
//  Comments+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by GLABBER on 20.11.2022.
//
//

import Foundation
import CoreData


extension Comments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comments> {
        return NSFetchRequest<Comments>(entityName: "Comments")
    }

    @NSManaged public var comments: String?
    @NSManaged public var comment: Person?

}

extension Comments : Identifiable {

}
