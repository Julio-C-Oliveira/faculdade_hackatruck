//
//  view.swift
//  09
//
//  Created by Turma01-24 on 19/03/26.
//

import SwiftUI

struct AppView: View {
    @StateObject var viewModel = ViewModel()
    @State private var mostrandoAddSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if viewModel.umaMusume.isEmpty {
                        Spacer()
                        ProgressView()
                            .controlSize(.extraLarge)
                            .scaleEffect(2.0)

                        
                        Text("Carregando...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.top, 10)
                        Spacer()
                    } else {
                        ListView(viewModel: viewModel)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { mostrandoAddSheet = true }) {
                            Label("Adicionar Nova", systemImage: "plus")
                        }
                        
                        Button(action: { viewModel.fetch() }) {
                            Label("Atualizar Lista", systemImage: "arrow.clockwise")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $mostrandoAddSheet) {
                AddEditView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetch()
            }
        }
        .refreshable {
            print("Recarregando...")
        }
    }
}
