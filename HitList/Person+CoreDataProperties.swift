//
//  Person+CoreDataProperties.swift
//  HitList
//
//  Created by Phoenix on 06.07.17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?

}
