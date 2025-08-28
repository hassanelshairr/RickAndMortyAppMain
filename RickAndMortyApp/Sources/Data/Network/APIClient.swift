//
//  APIClient.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import Foundation

protocol APIClient {
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

final class URLSessionAPIClient: APIClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = endpoint.urlRequest else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1)))
            return
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)); return }

            guard let http = response as? HTTPURLResponse,
                  (200..<300).contains(http.statusCode),
                  let data = data else {
                completion(.failure(NSError(domain: "Network", code: -2)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
