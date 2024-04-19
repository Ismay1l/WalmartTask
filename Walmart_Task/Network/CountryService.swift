//
//  CountryAPIService.swift
//  Walmart_Task
//
//  Created by Ismayil Ismayilov on 4/17/24.
//

import Foundation
import Combine

protocol Service {
    func request<T: Decodable>(_ url: URL, method: Method, parameters: [String: String]?, callback: @escaping (String) -> Void) -> AnyPublisher<T, Error>
}

class CountryService: Service {
    
    func request<T: Decodable>(_ url: URL, method: Method, parameters: [String: String]? = nil, callback: @escaping (String) -> Void) -> AnyPublisher<T, Error> {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if let parameters = parameters, !parameters.isEmpty {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let finalURL = components?.url else {
            callback(NetworkError.invalidURL.description)
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.description
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .tryMap { data in
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    return decodedObject
                } catch {
                    do {
                        let decodedArray = try JSONDecoder().decode([T].self, from: data)
                        guard let firstElement = decodedArray.first else {
                            callback(NetworkError.decodingError.description)
                            throw NetworkError.decodingError
                        }
                        return firstElement
                    } catch {
                        callback(NetworkError.decodingError.description)
                        throw NetworkError.decodingError
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


class MockCountryService: Service {
    func request<T>(_ url: URL, method: Method, parameters: [String : String]?, callback: @escaping (String) -> Void) -> AnyPublisher<T, Error> where T : Decodable {
        let jsonString = """
    {
          "capital": "Kabul",
          "code": "AF",
          "currency": {
            "code": "AFN",
            "name": "Afghan afghani",
            "symbol": "؋"
          },
          "flag": "https://restcountries.eu/data/afg.svg",
          "language": {
            "code": "ps",
            "name": "Pashto"
          },
          "name": "Afghanistan",
          "region": "AS"
     }
   """
        let publisher = Just(jsonString.data(using: .utf8)!)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                NetworkError.decodingError
            }
            .eraseToAnyPublisher()
        return publisher
    }
}
