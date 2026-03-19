//
//  viewmodel.swift
//  08
//
//  Created by Turma01-14 on 18/03/26.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var characters: [HaPo] = []
    @Published var selectedHouse: String = "Gryffindor" {
        didSet {
            fetch()
        }
    }
    
    let houses = ["Gryffindor", "Slytherin", "Hufflepuff", "Ravenclaw"]
    
    private let service = Service()
    private var cancellables = Set<AnyCancellable>()
    
    func fetch() {
        let housePath = selectedHouse.lowercased()
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters/house/\(housePath)") else {
            return
        }
        
        service.fetchHaPo(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { characters in
                self.characters = characters
            }
            .store(in: &cancellables)
    }
}
