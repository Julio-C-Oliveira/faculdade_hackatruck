//
//  viewmodel.swift
//  08
//
//  Created by Turma01-14 on 18/03/26.
//

import Foundation
import Combine

enum APIEndpoint {
    case get, post, put
    
    private var baseURL: String { "http://127.0.0.1:1880" }
    
    var url: URL? {
        switch self {
            case .get:  return URL(string: "\(baseURL)/getHatsuneMiku")
            case .post: return URL(string: "\(baseURL)/postHatsuneMiku")
            case .put:  return URL(string: "\(baseURL)/putHatsuneMiku")
        }
    }
}

class ViewModel: ObservableObject {
    @Published var umaMusume: [UmaMusume] = []
    
    private let service = Service()
    private var cancellables = Set<AnyCancellable>()
    
    func fetch() {
        guard let urlGet = APIEndpoint.get.url else { return }
        
        service.fetchUma(url: urlGet)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { umaMusume in
                self.umaMusume = umaMusume
            }
            .store(in: &cancellables)
    }
    
    func post(newUma: UmaMusume) {
        guard let urlPost = APIEndpoint.post.url else { return }
        
        service.addUma(uma: newUma, url: urlPost)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.fetch()
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func put(editedUma: UmaMusume) {
        guard let urlPut = APIEndpoint.put.url else { return }
        
        service.updateUma(uma: editedUma, url: urlPut)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.fetch()
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
