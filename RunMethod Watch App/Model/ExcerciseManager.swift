//
//  ExcerciseManager.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/08/16.
//

import SwiftUI

class ExcerciseManager: NSObject, ObservableObject{
    @Published var secondElapsed = 0.0
    @Published var status: exerciseStatus = .stop
    var timer = Timer()
    var locationManager: CLLocationManager?
    
    override init(){
        super.init()

        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()

    }

    enum exerciseStatus{
        case start
        case stop
        case pause
    }
    
    func startExcercise(){
        status = .start
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ timer in
            self.secondElapsed += 0.01
        }
    }

    func pauseExcercise(){
        status = .pause
        timer.invalidate()
    }

    func stopExcercise(){
        status = .stop
        timer.invalidate()
        secondElapsed = 0
    }
}

extension ExcerciseManager: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //
    }
}

