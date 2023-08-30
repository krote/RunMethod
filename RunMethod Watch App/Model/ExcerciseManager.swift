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
    var locationLogs:[CLLocation] = []
    
    private let motionManager = CMMotionManager()
    
    struct motion_point{
        var timeElapsed: Double
        var location_x: Double
        var location_y: Double
        var location_z: Double
    }
    var motionPoints: [motion_point] = []
    
    override init(){
        super.init()

        // 位置情報を5m移動するたびにdelegateを呼び出すようにする
        // 参考:https://medium.com/location-tracking-tech/%E4%BD%8D%E7%BD%AE%E6%83%85%E5%A0%B1%E3%82%92%E6%AD%A3%E7%A2%BA%E3%81%AB%E3%83%88%E3%83%A9%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0%E3%81%99%E3%82%8B%E6%8A%80%E8%A1%93-in-ios-%E7%AC%AC%EF%BC%93%E5%9B%9E-%E3%83%90%E3%83%83%E3%82%AF%E3%82%B0%E3%83%A9%E3%83%B3%E3%83%89%E3%81%AE%E3%81%A7%E3%83%88%E3%83%A9%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0-%E7%B2%BE%E5%BA%A6-%E3%83%90%E3%83%83%E3%83%86%E3%83%AA%E3%83%BC%E6%B6%88%E8%B2%BB-a49c3cdb4a5a
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

        // 位置情報に関する初期処理
        locationLogs.removeAll()
        
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

    func stopExcercise(){
        status = .stop
        timer.invalidate()
        secondElapsed = 0
        
        // モーションセンサー終了処理
        stopMonitoringMotion()
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
                    self?.motionPoints.append(motion_point(timeElapsed: self?.secondElapsed ?? 0, location_x: userAcceleration.x, location_y: userAcceleration.y, location_z: userAcceleration.z))
                }
            }
        }
    }
    
    private func stopMonitoringMotion(){
        if motionManager.isDeviceMotionActive{
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    func startVibration(){
        
    }
    
    func stopVibration(){
        
    }
    
    func saveResult(){
        // ここまでの結果を記録する
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
            
        var cnt = locations.count
        if let newLocation = locations.last{
            locationLogs.append(newLocation)
            print("\(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
        }
    }
}

