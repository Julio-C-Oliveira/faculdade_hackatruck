//
//  ContentView.swift
//  02
//
//  Created by Turma01-14 on 11/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    let size: CGFloat = 200
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 18.0)
            .repeatForever().repeatForever(autoreverses: false)
    }
    
    var body: some View {
        HStack {
            Image("hy5rf7z3fiud1")
                .resizable()
                .clipShape(.circle)
                .frame(width: size, height: size)
                .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                .animation(self.isAnimating ? foreverAnimation: .default)
                .onAppear{ self.isAnimating = true }
                .onDisappear{ self.isAnimating = false }
            VStack {
                Text("I").font(.title).foregroundStyle(.blue)
                Text("Use").font(.title2).foregroundStyle(.yellow)
                Text("Arch, BTW").font(.title2).foregroundStyle(.red)
            }
        }
        
    }
}

#Preview {
    ContentView()
}


