//
//  ContentView.swift
//  04
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
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            wallBrushView()
                .badge(0)
                .tabItem {
                Label("", systemImage: "paintbrush")
            }
            paperBrushView()
                .badge(0)
                .tabItem {
                Label("", systemImage: "paintbrush.pointed")
            }
            maxVerstappenView()
                .badge(1)
                .tabItem {
                Label("", systemImage: "car.rear")
            }
            listView()
                .badge(0)
                .tabItem {
                Label("", systemImage: "list.bullet")
            }
        }
    }
}

#Preview {
    ContentView()
}
