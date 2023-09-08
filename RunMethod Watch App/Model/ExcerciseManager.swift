//
//  ExcerciseManager.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/08/16.
//

import SwiftUI
import CoreMotion

class ExcerciseManager: NSObject, ObservableObject{
    @Published var secondElapsed = 0.0
    @Published var status: exerciseStatus = .stop
    var timer = Timer()
    var locationManager: CLLocationManager?
    var excerciseLogs:[ExcerciseLog] = []
    var currentExcerciseLog: ExcerciseLog?
    
    private let motionManager = CMMotionManager()
    
    override init(){
        super.init()
        
        // 位置情報を5m移動するたびにdelegateを呼び出すようにする
        locationManager = CLLocationManager()
        locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager!.distanceFilter = 5
        
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.allowsBackgroundLocationUpdates = true
        
        
    }
    
    enum exerciseStatus{
        case start
        case stop
        case pause
    }
    
    /// 運動の開始
    func startExcercise(){
        status = .start
        
        // 運動時間の記録
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ timer in
            self.secondElapsed += 0.01
        }
        
        currentExcerciseLog = ExcerciseLog()
        
        // デバイスのモーションセンサー値取得に関する処理
        startMonitoringMotion()
    }
    
    /// 運動の一時停止処理
    /// Description
    ///
    func pauseExcercise(){
        status = .pause
        timer.invalidate()
    }
    
    /// 運動の終了
    func stopExcercise(){
        status = .stop
        timer.invalidate()
        secondElapsed = 0
        
        // モーションセンサー終了処理
        stopMonitoringMotion()
    }
    
    func stopExcerciseAndSaveResult(){
        stopExcercise()
        // ここまでの結果を記録する
    }

    // MotionManagerに関する初期処理
    private func startMonitoringMotion(){
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.5
            motionManager.startDeviceMotionUpdates(to: .main) {[weak self] (data, error) in
                guard let data = data else {return}
                let threshold: Double = 0.1
                let userAcceleration = data.userAcceleration
                if abs(userAcceleration.x) > threshold || abs(userAcceleration.y) > threshold || abs(userAcceleration.z) > threshold {
                    self?.currentExcerciseLog?.addMotionPoint(time: self?.secondElapsed ?? 0, x: userAcceleration.x, y: userAcceleration.y, z: userAcceleration.z)
                }
            }
        }
    }
    
    private func stopMonitoringMotion(){
        if motionManager.isDeviceMotionActive{
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

extension ExcerciseManager: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
        if status == .pause || status == .stop{
            // 位置情報を取得しない
            return
        }
            
        if let newLocation = locations.last{
            currentExcerciseLog?.addLocationLog(location: newLocation)
        }
    }
}

