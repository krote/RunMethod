//
//  ExcerciseView.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/09/11.
//

import SwiftUI

struct ExcerciseView: View {
    var excerciseLog: ExcerciseLog
    var body: some View {
        VStack{
            Text("Total Distrance: \(excerciseLog.totalDistance)")
        }
    }
}

struct ExcerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExcerciseView(excerciseLog: ExcerciseLog())
    }
}
