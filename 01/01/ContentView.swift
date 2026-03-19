//
//  ContentView.swift
//  01
//
//  Created by Turma01-14 on 11/03/26.
//

import SwiftUI


struct ContentView: View {
    let size: CGFloat = 70
    var body: some View {
        HStack {
            VStack {
                Rectangle().frame(width: size, height: size).foregroundStyle(.red)
                Spacer()
                Rectangle().frame(width: size, height: size).foregroundStyle(.green)
            }
            Spacer()
            VStack {
                Rectangle().frame(width: size, height: size).foregroundStyle(.blue)
                Spacer()
                Rectangle().frame(width: size, height: size).foregroundStyle(.yellow)
            }
        }.padding()
    }
}

#Preview {
    ContentView()
}
