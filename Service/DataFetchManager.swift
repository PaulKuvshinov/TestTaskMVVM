//
//  DataFetchManager.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getList(complition: @escaping (Result<MainData, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    private let urlString = "https://www.roxiemobile.ru/careers/test/orders.json"
    
    func getList(complition: @escaping (Result<MainData, Error>) -> Void) {
        request(url: urlString) { (result: Result<MainData, Error>) in
            switch result {
            case .success (let success):
                DispatchQueue.main.async {
                    complition(.success(success))
                }
            case .failure (let failure):
                DispatchQueue.main.async {
                    complition(.failure(failure))
                }
            }
        }
    }
    
    func request<T: Decodable>(url: String, complition: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data else {
                if let error = error {
                    DispatchQueue.main.async {
                        complition(.failure(NetworkError.serverError(error: error)))
                    }
                    return
                }
                DispatchQueue.main.async {
                    complition(.failure(NetworkError.lostNetworkConnection))
                }
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
                do {
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        complition(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure((NetworkError.incorrectData)))
                    }
                }
            }
            task.resume()
    }
}
