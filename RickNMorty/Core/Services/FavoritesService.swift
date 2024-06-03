//
//  FavoritesService.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 28/05/2024.
//

import Foundation

final class FavoritesService {
    private var favorites: [Int] = []
    private let defaults = UserDefaults.standard

    static let shared = FavoritesService()
    var delegate: FavoriteTouchDelegate?

    private init() {
        self.favorites = defaults.object(forKey: StorageKey.FAVORITES) as? [Int] ?? [Int]()
    }

    func toggleFavorite(with id: Int) {
        if favorites.contains(id) {
            favorites.remove(at: favorites.firstIndex(of: id)!)
        } else {
            favorites.append(id)
        }
        defaults.set(favorites, forKey: StorageKey.FAVORITES)
        delegate?.didFavoriteSet(isFavorite: isFavorite(id))
    }

    func isFavorite(_ id: Int) -> Bool {
        return favorites.contains(id)
    }
}
