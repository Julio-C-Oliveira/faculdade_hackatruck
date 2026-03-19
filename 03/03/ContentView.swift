//
//  ContentView.swift
//  03
//
//  Created by Turma01-14 on 12/03/26.
//

import SwiftUI

import AVFoundation
var audioPlayer: AVAudioPlayer?

struct ContentView: View {
    @State private var choice: String = ""
    @State private var intChoice: Int = 0
    @State private var wallpapers: [String] = ["interrogation-mark", "lady-gaga", "sabrinha", "cr7", "taylor", "britney"]
    @State private var backgroudColorList: [Color] = [Color.gray, Color.ladyGaga, Color.sabrinha, Color.cr7, Color.taylor, Color.britney]
    
    @State private var isAnimating = false
    let size: CGFloat = 300
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 18.0)
            .repeatForever(autoreverses: false)
    }
    
    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Arquivo \(soundName).mp3 não encontrado")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Erro ao reproduzir áudio: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack {
            TextField("Choice a number", text: $choice)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Selecionar") {
                intChoice = Int(choice) ?? Int.random(in: 1 ... 5)
                
                playSound(soundName: wallpapers[intChoice])
            }
                .padding(10)
                .background(Color.white)
                .foregroundStyle(.black)
                .cornerRadius(100)
            
            Spacer()
            
            Image(wallpapers[intChoice])
                .resizable()
                .clipShape(.circle)
                .frame(width: size, height: size)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(isAnimating ? foreverAnimation : .default, value: isAnimating)
                .onAppear{ self.isAnimating = true }
                .onDisappear{ self.isAnimating = false }
            
            Spacer()
            
            VStack {
                ForEach(0..<wallpapers.count, id: \.self) { index in
                        HStack {
                            Text("[\(index)] - \(wallpapers[index].capitalized)")
                                .colorInvert()
                            
                            Circle()
                                .frame(width: 15)
                                .foregroundStyle(backgroudColorList[index])
                        }
                    }
            }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Color.black)
                .cornerRadius(7)
            
        }.padding().background(backgroudColorList[intChoice])
    }
}

#Preview {
    ContentView()
}
