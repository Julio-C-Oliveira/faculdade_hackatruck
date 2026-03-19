//
//  view.swift
//  08
//
//  Created by Turma01-14 on 18/03/26.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(viewModel.characters) { character in
                NavigationLink(destination: CharacterView(character: character)) {
                    HStack(spacing: 15) {
                        AsyncImage(url: URL(string: character.image ?? "")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                        
                        Text(character.name ?? "Desconhecido")
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct CharacterView: View {
    let character: HaPo
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                AsyncImage(url: URL(string: character.image ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .padding(40)
                }
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.red, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.top, 30)

                VStack(alignment: .leading, spacing: 20) {
                    
                    InfoRow(label: "Name", value: character.name ?? "Unknown")
                    Divider()
                    
                    InfoRow(label: "House", value: character.house ?? "No House")
                    Divider()
                    
                    InfoRow(label: "Birth", value: character.yearOfBirth != nil ? "\(character.yearOfBirth!)" : "Unknown")
                    Divider()
                    
                    InfoRow(label: "Eyes", value: character.eyeColour?.capitalized ?? "Unknown")
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle(character.name ?? "Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.headline)
        }
    }
}

struct AppView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image("harry")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 80)
                    
                    Menu {
                        Picker("Selecionar Casa", selection: $viewModel.selectedHouse) {
                            ForEach(viewModel.houses, id: \.self) { house in
                                Text(house).tag(house)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Casa: **\(viewModel.selectedHouse)**")
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    ListView(viewModel: viewModel)
                }
            }
        }
            .frame(maxWidth: .infinity)
            .onAppear() {
                viewModel.fetch()
            }
    }
}
