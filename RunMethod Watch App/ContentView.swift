//
//  ContentView.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/08/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var excerciseManager = ExcerciseManager()

    var body: some View {
        VStack {
            Spacer()
            Text(String(format: "%.2f", excerciseManager.secondElapsed))
                .fontWeight(.bold)
                .font(.largeTitle)
            
            Spacer()
            
            if excerciseManager.status == .stop {
                HStack{
                    VStack{
                        Image(systemName: "play")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                excerciseManager.startExcercise()
                            }
                        Text("Start")
                            .fontWeight(.heavy)
                    }
                    VStack{
                        Image(systemName: "square.and.arrow.down")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .onTapGesture{
                                excerciseManager.saveResult()
                            }
                        Text("Save")
                            .fontWeight(.heavy)
                    }
                }
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
                Text("Pause!")
            }
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
