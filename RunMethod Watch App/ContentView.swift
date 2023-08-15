//
//  ContentView.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/08/14.
//

import SwiftUI

struct ContentView: View {
    var isStarted: Bool = false
    var elapsedTime: Double = 0.0
    var body: some View {
        VStack {
            Text("")
            if isStarted == false {
                Image(systemName: "play")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Start")
            }else{
                Image(systemName: "stop")
                Text("Stop!")
            }
        }
        .padding()
    }
    
    func tappedStart(){
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.elapsedTime += 0.01
            self.isStarted = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isStarted: false, elapsedTime: 0)
    }
}
