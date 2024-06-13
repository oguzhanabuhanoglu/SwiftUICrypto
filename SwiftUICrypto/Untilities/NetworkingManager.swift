//
//  NetworkingManager.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 25.05.2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse: return "[🔥]Bad Response From URL."
            case .unknown: return "[⚠️]Unknown Error Occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0) })
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse
        }
        return output.data
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<any Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    // how it can coded without networking manager (full code in same place)
    /*func deneme(url: URL){
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw NetworkingError.badURLResponse
                }
                return output.data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case.failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedCoins in
                // get model into our array
            }

    }*/
}
