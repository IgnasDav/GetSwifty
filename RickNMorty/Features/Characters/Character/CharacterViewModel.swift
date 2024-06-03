//
//  CharacterViewModel.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 29/05/2024.
//

import Foundation

class CharacterViewModel {
    private var character: Character?
    let favoritesService = FavoritesService.shared

    func setCharacter(_ character: Character?) {
        self.character = character
    }

    func toggleFavorite(id: Int?) {
        if let id = id {
            favoritesService.toggleFavorite(with: id)
        }
    }

    func getIsFavorite() -> Bool {
        if let id = character?.id {
            return favoritesService.isFavorite(id)
        }
        return false
    }
}
