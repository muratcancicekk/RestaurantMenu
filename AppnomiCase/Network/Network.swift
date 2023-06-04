//
//  Network.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation

// MARK: - NetworkError
enum NetworkError {
    case requestFailure(String)
    case unknown(String)
    case noJSONData(String)
    case serverFailure(String)
    case userNotExist(String)
    case processNotAccepted(String)
}

struct Network {
    static let shared = Network()
    private let baseUrlString = Constants.baseURL
    func request<T: Decodable>(with type: RequestType, completion: @escaping (Result<T, CustomError>) -> Void) {
        guard let url = URL(string: baseUrlString + type.endPoint) else {
            Logger.log(text: "Failed to create url")
            return
        }
        let headers = [
            "Api-Key": Constants.apiKey,
            "Alias-Key": Constants.aliasKey,
        ]
        Logger.log(text:"** Request URL: " + baseUrlString + type.endPoint)
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(CustomError(message: "Failed to create data")))
                return
            }
            Logger.log(type: .info, text: String(data: data, encoding: .utf8.self) ?? "")
            let decoder = JSONDecoder()
            do {
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            }
            catch let error {
                completion(.failure(CustomError(message: error.localizedDescription)))
            }
        }.resume()
    }
}
