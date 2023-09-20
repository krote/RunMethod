//
//  ExcerciseData+CoreDataProperties.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/09/20.
//
//

import Foundation
import CoreData


extension ExcerciseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExcerciseData> {
        return NSFetchRequest<ExcerciseData>(entityName: "ExcerciseData")
    }

    @NSManaged public var trainingName: String?
    @NSManaged public var startDateTIme: Date?
    @NSManaged public var endDateTime: Date?
    @NSManaged public var totalDistance: Double
    @NSManaged public var pointDetails: NSSet?

}

// MARK: Generated accessors for pointDetails
extension ExcerciseData {

    @objc(addPointDetailsObject:)
    @NSManaged public func addToPointDetails(_ value: ExcercisePointData)

    @objc(removePointDetailsObject:)
    @NSManaged public func removeFromPointDetails(_ value: ExcercisePointData)

    @objc(addPointDetails:)
    @NSManaged public func addToPointDetails(_ values: NSSet)

    @objc(removePointDetails:)
    @NSManaged public func removeFromPointDetails(_ values: NSSet)

}

extension ExcerciseData : Identifiable {

}
