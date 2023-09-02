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
                            .frame(height: 30)
                        Text("Start")
                            .fontWeight(.heavy)
                    }
                }
            }else if excerciseManager.status == .pause{
                HStack{
                    VStack{
                        Image(systemName: "play")
                            .onTapGesture {
                                excerciseManager.startExcercise()
                            }
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .frame(height: 30)
                        Text("Resume")
                            .fontWeight(.heavy)
                    }
                    VStack{
                        Image(systemName: "square.and.arrow.down")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .onTapGesture{
                                excerciseManager.saveResult()
                            }
                            .frame(height: 30)
                        Text("Save")
                            .fontWeight(.heavy)
                    }
                }
            }else{
                // status == start
                Image(systemName: "pause")
                    .onTapGesture {
                        excerciseManager.pauseExcercise()
                    }
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .frame(height: 30)
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
