//
//  view.swift
//  09
//
//  Created by Turma01-24 on 19/03/26.
//

import SwiftUI

struct AppView: View {
    @StateObject var viewModel = ViewModel()
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack {
            Group { 
                if viewModel.umaMusume.isEmpty {
                    VStack {
                        Spacer()
                        ProgressView()
                            .controlSize(.extraLarge)
                            .scaleEffect(2.0)
                        
                        Text("Carregando...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.top, 10)
                        Spacer()
                    }
                } else {
                    ListView(viewModel: viewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { showingAddSheet = true }) {
                            Label("Adicionar Nova", systemImage: "plus")
                        }
                        Button(action: { viewModel.fetch() }) {
                            Label("Atualizar Lista", systemImage: "arrow.clockwise")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle").font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddVUmaView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}
