//
//  ContentView.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/08/14.
//

import SwiftUI

struct ContentView: View {
    var isStarted: Bool = false
    @ObservedObject var excerciseManager = ExcerciseManager()

    var body: some View {
        VStack {
            Text(String(format: "%.1f", excerciseManager.secondElapsed))
            
            Spacer()
            
            if excerciseManager.status == .stop {
                Image(systemName: "play")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        excerciseManager.startExcercise()
                    }
                Text("Start")
            }else if excerciseManager.status == .pause{
                HStack{
                    Image(systemName: "play")
                        .onTapGesture {
                            excerciseManager.startExcercise()
                        }
                    Image(systemName: "stop")
                        .onTapGesture {
                            excerciseManager.stopExcercise()
                        }
                }
            }else{
                // status == start
                Image(systemName: "pause")
                    .onTapGesture {
                        excerciseManager.pauseExcercise()
                    }
                Text("Stop!")
            }
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isStarted: false)
    }
}
