//
//  model.swift
//  08
//
//  Created by Turma01-14 on 18/03/26.
//

import Foundation
import Combine

struct Service {
    func fetchUma(url: URL) -> AnyPublisher<[UmaMusume], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [UmaMusume].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func addUma(uma: UmaMusume, url: URL) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(uma)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .mapError { $0 as Error } 
            .eraseToAnyPublisher()
    }

    func updateUma(uma: UmaMusume, url: URL) -> AnyPublisher<Data, Error> {
        let updateURL = url.appendingPathComponent(uma.id)
        var request = URLRequest(url: updateURL)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(uma)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

struct UmaMusume: Codable, Identifiable {
    let id: String
    let rev: String?
    let umaName: String?
    let umaIcon: String?
    let umaSong: String?
    let umaPhrase: String?
    let umaDescription: String?
    let umaColors: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rev = "_rev"
        case umaName, umaIcon, umaSong, umaPhrase, umaDescription, umaColors
    }
}
