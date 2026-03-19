//
//  view-get.swift
//  08
//
//  Created by Turma01-14 on 18/03/26.
//

import SwiftUI
import WebKit

struct CharacterView: View {
    let umaMusume: UmaMusume
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                AsyncImage(url: URL(string: umaMusume.umaIcon ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(hex: umaMusume.umaColors?.first ?? "#FF0000"), lineWidth: 4))
                .shadow(radius: 10)
                .padding(.top, 30)

                VStack(alignment: .leading, spacing: 20) {
                    InfoRow(label: "Name", value: umaMusume.umaName ?? "Unknown")
                    Divider()
                    
                    Text("Catchphrase")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\"\(umaMusume.umaPhrase ?? "")\"")
                        .font(.body)
                        .italic()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Divider()
                    
                    Text("Biography")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(umaMusume.umaDescription ?? "No description available.")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if let songUrl = umaMusume.umaSong, let url = URL(string: songUrl) {
                        Link(destination: url) {
                            HCenter {
                                Label("Listen to Theme Song", systemImage: "music.note.list")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top, 10)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal)
            }
        }
        .navigationTitle(umaMusume.umaName ?? "Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HCenter<Content: View>: View {
    let content: () -> Content
    var body: some View {
        HStack {
            Spacer()
            content()
            Spacer()
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var whoUma: UmaMusume? 
    @State private var showingEditSheet = false
    
    var body: some View {
        List {
            ForEach(viewModel.umaMusume) { umaMusume in
                NavigationLink(destination: CharacterView(umaMusume: umaMusume)) {
                    HStack(spacing: 15) {
                        AsyncImage(url: URL(string: umaMusume.umaIcon ?? "")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        
                        Text(umaMusume.umaName ?? "Desconhecido")
                            .font(.headline)
                        
                        Spacer()
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                        whoUma = umaMusume
                        showingEditSheet = true
                    } label: {
                        Label("Editar", systemImage: "pencil")
                    }
                    .tint(.orange)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        if let rev = umaMusume.rev {
                            viewModel.delete(id: umaMusume.id, rev: rev)
                        }
                    } label: {
                        Label("Deletar", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .sheet(isPresented: $showingEditSheet) {
            if let uma = whoUma {
                EditUmaView(viewModel: viewModel, originalUma: uma)
            }
        }
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

struct YouTubePlayerView: UIViewRepresentable {
    let videoURL: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: videoURL) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: url))
    }
}
