//
//  CharactersLoader.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 16/05/2024.
//
import Foundation

class CharactersLoader {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void ) {
        let url = URL(string: Constants.fullUrl + Constants.charactersEndpoint)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Wrong response code \((response as? HTTPURLResponse)?.statusCode)")
                return
            }
            guard let data = data else {
                print("No data?")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(CharactersApi.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
