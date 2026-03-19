//
//  ContentView.swift
//  05
//
//  Created by Turma01-14 on 13/03/26.
//

import SwiftUI

struct wallBrushView: View {
    var body: some View {
        VStack {
            Image(systemName: "paintbrush")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(Color.pink)
                .padding(50)
                .background(Color.black)
                .clipShape(.circle)
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pink)
    }
}

struct paperBrushView: View {
    var body: some View {
        VStack {
            Image(systemName: "paintbrush.pointed")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(Color.cyan)
                .padding(50)
                .background(Color.black)
                .clipShape(.circle)
                .foregroundStyle(.white)
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cyan)
    }

}

struct maxVerstappenView: View {
    var body: some View {
        Image("max-verstappen")
    }
}

struct listView: View {
    var phrase: String
    var body: some View {
        VStack {
            Text("Lista")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            List {
                Text("A List Item")
                Text("A Second List Item")
                Text("A Third List Item")
                if phrase != "" {
                    Text(phrase)
                }
            }
        }
    }
}

struct GridCard: View {
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(color)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var phrase: String = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            NavigationStack {
                Text("Seleciona Ai").font(.title).fontWeight(.bold)
                
                TextField("Digite algo", text: $phrase)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        NavigationLink(destination: wallBrushView()) {
                            GridCard(icon: "paintbrush", color: .pink)
                        }
                        
                        NavigationLink(destination: paperBrushView()) {
                            GridCard(icon: "paintbrush.pointed", color: .blue)
                        }
                        
                        NavigationLink(destination: maxVerstappenView()) {
                            GridCard(icon: "car.fill", color: .purple)
                        }
                        
                        NavigationLink(destination: listView(phrase: phrase)) {
                            GridCard(icon: "list.bullet", color: .gray)
                        }
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
