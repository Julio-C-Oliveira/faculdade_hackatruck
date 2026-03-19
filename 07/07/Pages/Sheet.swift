//
//  Sheet.swift
//  07
//
//  Created by Turma01-14 on 17/03/26.
//

import SwiftUI

struct SheetView: View {
    var location: Location
    
    var body: some View {
        VStack(spacing: 20) {
            Text(location.name)
                .font(.largeTitle)
                .bold()
                .padding(.top)

            // Se você tiver imagens no assets, pode usar aqui
            if !location.image.isEmpty {
                Image(location.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(15)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .frame(height: 200)
                    .cornerRadius(15)
                    .overlay(Text("Sem Imagem").foregroundColor(.secondary))
            }
            
            ScrollView {
                Text(location.description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}
