//
//  ExerciseLog.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/08/14.
//

import Foundation
import CoreMotion
import SwiftUI

class ExcerciseLog: NSObject{
    var startDateTime: Date
    struct motion_point{
        var timeElapsed: Double
        var location_x: Double
        var location_y: Double
        var location_z: Double
    }
    var motionPoints: [motion_point] = []
    var locationLogs:[CLLocation] = []

    
    override init() {
        //
        startDateTime = Date()
    }
    func addMotionPoint(time: Double, x:Double, y:Double, z:Double){
        motionPoints.append(motion_point(timeElapsed: time, location_x: x, location_y: y, location_z: z))
    }
    func addLocationLog(location: CLLocation){
        
    }
}
