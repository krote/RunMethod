//
//  ExerciseLog.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/08/14.
//

import Foundation
import CoreMotion
import SwiftUI

/// 運動に関するデータを管理するクラス
class ExcerciseLog: NSObject{
    struct motion_point{
        var timeElapsed: Double
        var location_x: Double
        var location_y: Double
        var location_z: Double
    }
    var motionPoints: [motion_point] = []
    var locationLogs:[CLLocation] = []

    struct operationLog{
        var operationTime: Date
        var operationStatus: operationStatus
    }
    var operationLogs: [operationLog] = []
    
    override init() {
        super.init()
        // 開始時刻の記録
        startLogging()
    }
    func addMotionPoint(time: Double, x:Double, y:Double, z:Double){
        motionPoints.append(motion_point(timeElapsed: time, location_x: x, location_y: y, location_z: z))
    }
    func addLocationLog(location: CLLocation){
        locationLogs.append(location)
    }
    func startLogging(){
        operationLogs.append(operationLog(operationTime: Date(), operationStatus: .start))
    }
    func pauseLogging(){
        operationLogs.append(operationLog(operationTime: Date(), operationStatus: .pause))
    }
    func endLogging(){
        operationLogs.append(operationLog(operationTime: Date(), operationStatus: .stop))
    }
}
