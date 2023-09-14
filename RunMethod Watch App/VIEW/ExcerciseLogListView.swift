//
//  ShowExcerciseLogView.swift
//  RunMethod Watch App
//
//  Created by to-matsushita on 2023/09/03.
//

import SwiftUI

let testData: ExcerciseLog = ExcerciseLog()

struct ExcerciseLogListView: View {
    var dataList: [ExcerciseLog] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func loadData(){
        
    }
}

struct ShowExcerciseLogView_Previews: PreviewProvider {
    static var previews: some View {
        ExcerciseLogListView()
    }
}
