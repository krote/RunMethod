//
//  ExcerciseManager.swift
//  RunMethod Watch App
//
//  Created by krote on 2023/08/16.
//

import SwiftUI
import CoreMotion

enum operationStatus{
    case start
    case stop
    case pause
}

class ExcerciseManager: NSObject, ObservableObject{
    @Published var secondElapsed = 0.0
    @Published var status: operationStatus = .stop
    var timer = Timer()
    var locationManager: CLLocationManager?
    var excerciseLogs:[ExcerciseLog] = []
    var currentExcerciseLog: ExcerciseLog?
    
    private let motionManager = CMMotionManager()
    
    override init(){
        super.init()
        
        // 位置情報を5m移動するたびにdelegateを呼び出すようにする
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else {
            // 位置情報が取得できないのであれば以下は不要
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 5
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
    }
    /// 運動の開始
    func startExcercise(){
        status = .start
        
        // 運動時間の記録
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ timer in
            self.secondElapsed += 0.01
        }
        
        currentExcerciseLog = ExcerciseLog()
        guard let excerciseLog = currentExcerciseLog else{
            return
        }
        excerciseLog.startLogging()

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
            
            // 動きに変化があった場合に記録する関数の定義
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
            guard let currentLog = currentExcerciseLog else {
                return
            }
            currentLog.addLocationLog(time: secondElapsed, location: newLocation)
        }
    }
}

