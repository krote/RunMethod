//
//  ExcercisePointData+CoreDataProperties.swift
//  RunMethod Watch App
//
//  Created by krote on 2023/09/20.
//
//

import Foundation
import CoreData


extension ExcercisePointData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExcercisePointData> {
        return NSFetchRequest<ExcercisePointData>(entityName: "ExcercisePointData")
    }

    @NSManaged public var pointDateTime: Date?
    @NSManaged public var pointLatitude: Double
    @NSManaged public var pointLongtitude: Double
    @NSManaged public var pointDistance: Double

}

extension ExcercisePointData : Identifiable {

}
