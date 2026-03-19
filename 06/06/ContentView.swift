//
//  ContentView.swift
//  06
//
//  Created by Turma01-14 on 16/03/26.
//

import SwiftUI

struct VerticalView: View {
    let viewName: String
    let contentArray: [Content]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewName)
                .font(.title2)
                .bold()
                .padding(.horizontal)

            ForEach(contentArray, id: \.self) { content in
                NavigationLink(destination: PageView(content: content)) {
                    HStack {
                        AsyncImage(url: URL(string: content.coverURL)) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFill()
                            } else if phase.error != nil {
                                Color.red.overlay(Text("Erro!"))
                            } else {
                                ProgressView()
                            }
                        }
                            .frame(width: 80, height: 120)
                            .cornerRadius(10)
                            .clipped()
                        
                        Text(content.name)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct HorizontalView: View {
    let viewName: String
    let contentArray: [Content]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewName)
                .font(.title2)
                .bold()
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(contentArray, id: \.self) { content in
                        NavigationLink(destination: PageView(content: content)) {
                            AsyncImage(url: URL(string: content.coverURL)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else if phase.error != nil {
                                    Color.red
                                        .overlay(Text("!"))
                                } else {
                                    ProgressView()
                                }
                            }
                                .frame(width: 120, height: 180)
                                .cornerRadius(15)
                                .clipped()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PageView: View {
    let content: Content
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: content.coverURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    Color.red
                        .overlay(Text("!"))
                } else {
                    ProgressView()
                }
            }
            .frame(width: 180, height: 270)
            .cornerRadius(15)
            .clipped()
            
            Text(content.name)
                .font(.title3)
                .bold()
                .lineLimit(1)
            
            // Badge de Categoria e Ano
            HStack(spacing: 8) {
                Text(content.category.rawValue.capitalized)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(4)
                
                Text("\(String(content.year))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(content.gender.map { $0.rawValue }.joined(separator: " • "))
                .font(.caption2)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)
                
                Text(String(format: "%.1f", content.malScore))
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text("/ 10")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}


struct AppView: View {
    var body: some View {
        let movies: [Content] = contentArray.filter { $0.category == ContentType.movie }
        let series: [Content] = contentArray.filter { $0.category == ContentType.serie }
        let topRated = contentArray.sorted { $0.malScore > $1.malScore }
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image("Apple_TV_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 80)
                    
                    VerticalView(viewName: "Filmes", contentArray: movies)
                    
                    VerticalView(viewName: "Séries", contentArray: series)
                    
                    HorizontalView(viewName: "Recomendações", contentArray: topRated)
                }
                .padding(.vertical)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView: View {
    var body: some View {
        AppView()
    }
}

#Preview {
    ContentView()
}
