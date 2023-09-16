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
        var motion_x: Double
        var motion_y: Double
        var motion_z: Double
    }
    var motionPoints: [motion_point] = []
    struct location_log{
        var timeElapsed: Double
        var timeInterval: Double
        var distance: Double
        var location: CLLocation
    }
    var locationLogs:[location_log] = []

    struct operationLog{
        var operationTime: Date
        var operationStatus: operationStatus
    }
    var operationLogs: [operationLog] = []
    var totalDistance: Double = 0
    
    override init() {
        super.init()
    }
    func addMotionPoint(time: Double, x:Double, y:Double, z:Double){
        motionPoints.append(motion_point(timeElapsed: time, motion_x: x, motion_y: y, motion_z: z))
    }
    func addLocationLog(time: Double, location: CLLocation){
        // 最後の位置情報から距離を算出し加算する
        let cnt = locationLogs.count
        let thisDistance = locationLogs[cnt-1].location.distance(from: location)
        let interval = time - locationLogs[cnt-1].timeElapsed
        // 位置情報追加
        locationLogs.append(location_log(timeElapsed: time,timeInterval: interval, distance: thisDistance, location: location))
        totalDistance += thisDistance
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
    
    func setTestData(){
        //operationLogs
        var dateTime = Date()
        operationLogs.append(operationLog(operationTime: dateTime, operationStatus: .start))
        dateTime = dateTime.addingTimeInterval(100)
        operationLogs.append(operationLog(operationTime: dateTime, operationStatus: .pause))
        dateTime = dateTime.addingTimeInterval(100)
        operationLogs.append(operationLog(operationTime: dateTime, operationStatus: .stop))
    }
}
