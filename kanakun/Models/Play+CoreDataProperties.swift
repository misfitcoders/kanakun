//
//  Play+CoreDataProperties.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 23/07/2020.
//
//

import Foundation
import CoreData


extension Play {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Play> {
        return NSFetchRequest<Play>(entityName: "Play")
    }

    @NSManaged public var content: String?
    @NSManaged public var term: String?
    @NSManaged public var senses: String?
    @NSManaged public var slug: String?
    @NSManaged public var page: Int16
    @NSManaged public var played: Bool
    @NSManaged public var failed: Int16

}
