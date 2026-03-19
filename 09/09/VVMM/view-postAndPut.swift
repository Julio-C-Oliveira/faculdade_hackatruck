//
//  view-postAndPut.swift
//  09
//
//  Created by Turma01-24 on 19/03/26.
//

import SwiftUI

struct AddVUmaView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var song: String = ""
    @State private var phrase: String = ""
    @State private var description: String = ""
    @State private var color1: String = "#FFFFFF"
    @State private var color2: String = "#000000"

    var body: some View {
        NavigationStack {
            Form {
                Section("Nova Personagem") {
                    TextField("Nome", text: $name)
                    TextField("URL do Ícone", text: $icon)
                    TextField("URL da Música", text: $song)
                }
                
                Section("Detalhes") {
                    TextField("Frase", text: $phrase)
                    TextEditor(text: $description).frame(height: 80)
                }
                
                Section("Cores") {
                    TextField("Cor 1", text: $color1)
                    TextField("Cor 2", text: $color2)
                }
                
                Button("Cadastrar UmaMusume") {
                    let new = UmaMusume(
                        id: UUID().uuidString,
                        rev: nil,
                        umaName: name,
                        umaIcon: icon,
                        umaSong: song,
                        umaPhrase: phrase,
                        umaDescription: description,
                        umaColors: [color1, color2]
                    )
                    viewModel.post(newUma: new)
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
            .navigationTitle("Adicionar")
        }
    }
}

struct EditUmaView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    let originalUma: UmaMusume
    
    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var song: String = ""
    @State private var phrase: String = ""
    @State private var description: String = ""
    @State private var color1: String = ""
    @State private var color2: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Alterar Informações de \(originalUma.umaName ?? "")") {
                    TextField("Nome", text: $name)
                    TextField("URL do Ícone", text: $icon)
                    TextField("URL da Música", text: $song)
                }
                
                Section("Personalidade e Biografia") {
                    TextField("Frase de Efeito", text: $phrase)
                    TextEditor(text: $description) 
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                }
                
                Section("Cores Atuais") {
                    TextField("Cor 1", text: $color1)
                    TextField("Cor 2", text: $color2)
                }

                Button("Salvar Alterações") {
                    let edited = UmaMusume(
                        id: originalUma.id,
                        rev: originalUma.rev,
                        umaName: name,
                        umaIcon: icon,
                        umaSong: song,
                        umaPhrase: phrase,
                        umaDescription: description,
                        umaColors: [color1, color2]
                    )
                    viewModel.put(editedUma: edited)
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
            .navigationTitle("Editar")
            .onAppear {
                name = originalUma.umaName ?? ""
                icon = originalUma.umaIcon ?? ""
                song = originalUma.umaSong ?? ""
                phrase = originalUma.umaPhrase ?? ""
                description = originalUma.umaDescription ?? ""
                color1 = originalUma.umaColors?.first ?? "#FFFFFF"
                color2 = originalUma.umaColors?.last ?? "#000000"
            }
        }
    }
}