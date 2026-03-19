//
//  view-postAndPut.swift
//  09
//
//  Created by Turma01-24 on 19/03/26.
//

import SwiftUI

struct AddEditView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var song: String = ""
    @State private var phrase: String = ""
    @State private var description: String = ""
    @State private var color1: String = "#FFFFFF"
    @State private var color2: String = "#000000"
    
    var umaParaEditar: UmaMusume?

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Informações Básicas")) {
                    TextField("Nome da UmaMusume", text: $name)
                    TextField("URL do Ícone", text: $icon)
                    TextField("URL da Música (YouTube)", text: $song)
                }
                
                Section(header: Text("Personalidade")) {
                    TextField("Frase de Efeito", text: $phrase)
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Cores de Destaque (Hex)")) {
                    TextField("Cor Primária (ex: #CA46B0)", text: $color1)
                    TextField("Cor Secundária (ex: #B52542)", text: $color2)
                }
                
                Button(action: salvar) {
                    HCenter {
                        Text(umaParaEditar == nil ? "Adicionar" : "Salvar Alterações")
                            .bold()
                    }
                }
                .disabled(name.isEmpty)
            }
            .navigationTitle(umaParaEditar == nil ? "Nova Uma" : "Editar Uma")
            .onAppear {
                if let uma = umaParaEditar {
                    name = uma.umaName ?? ""
                    icon = uma.umaIcon ?? ""
                    song = uma.umaSong ?? ""
                    phrase = uma.umaPhrase ?? ""
                    description = uma.umaDescription ?? ""
                }
            }
        }
    }

    func salvar() {
        let newUma = UmaMusume(
            id: umaParaEditar?.id ?? UUID().uuidString,
            umaName: name,
            umaIcon: icon,
            umaSong: song,
            umaPhrase: phrase,
            umaDescription: description,
            umaColors: ["#000000"]
        )

        if umaParaEditar == nil {
            viewModel.post(newUma: newUma)
        } else {
            viewModel.put(editedUma: newUma)
        }
        
        dismiss()
    }
}
