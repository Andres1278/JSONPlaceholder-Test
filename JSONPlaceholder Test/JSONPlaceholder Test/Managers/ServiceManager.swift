//
//  ServiceManager.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 22/08/22.
//

import Foundation
import Alamofire

struct ServiceManger {
    
    enum NetworkError: Error {
        case badURL
        case noJSONData
        case JSONDecoder
        case unauthorized
        case unknown
    }
    
    typealias Completion<T> = (CompletionResult<T>) -> (Void)
    typealias CompletionResult<T> = Result<T, Error>
    
    public static func request<T: Codable> (
        to endpoint: String,
        method: Alamofire.HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        keypath: String? = nil,
        completionHandler: Completion<T>?
    ) {
        
        guard let url = URL(string: endpoint) else {
            completionHandler?(.failure(NetworkError.badURL))
            return
        }
        AF.request(url, method: method, parameters: parameters, encoding: encoding).responseJSON { (response) in
            
            if let error = error(for: response.response?.statusCode) {
                completionHandler?(.failure(error))
                return
            }
            
            guard let json: Any = response.value else {
                completionHandler?(.failure(NetworkError.noJSONData))
                return
            }
            
            do {
                guard JSONSerialization.isValidJSONObject(json) else {
                    completionHandler?(.failure(NetworkError.JSONDecoder))
                    return
                }
                let data = try JSONSerialization.data(withJSONObject: json, options: [])
                let entries = try JSONDecoder().decode(T.self, from: data as Data)
                completionHandler?(.success(entries))
            } catch  {
                print("[ServiceManager] Codable decoding error: \(error)")
                completionHandler?(.failure(NetworkError.JSONDecoder))
            }
        }
    }
    
    static func error(for code: Int?) -> Error? {
        guard let code = code else {
            return nil
        }
        switch code {
        case 200...299:
            return nil
        case 400...499:
            return NetworkError.unauthorized
        default:
            return NetworkError.unknown
        }
    }
}


