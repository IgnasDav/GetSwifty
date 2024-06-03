//
//  CharactersViewModel.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/05/2024.
//

import Foundation

class CharactersViewModel {
    var onCharactersUpdated: (() -> Void)?
    var onCharactersError: ((_ error: Error) -> Void)?

    private let favoritesService = FavoritesService.shared

    private let charactersLoader = CharactersLoader()
    private(set) var characters: [Character] = [] {
        didSet {
            onCharactersUpdated?()
        }
    }

    init() {
        fetchCharacters()
    }

    func fetchCharacters() {
        charactersLoader.fetchCharacters { [weak self] result in
            switch result {
                case .success(let characters):
                    self?.characters = characters
                case .failure(let error):
                    print("Ojojoj, \(String(describing: error))")
                    self?.onCharactersError?(error)
            }
        }
    }

    func filterCharactersByFavoritesToggle(type: CharactersToggleOptions.RawValue) {
        switch type {
            case CharactersToggleOptions.all.rawValue:
                fetchCharacters()
            case CharactersToggleOptions.favorites.rawValue:
                filterCharactersByFavorites()
            default:
                return
        }
    }

    private func filterCharactersByFavorites() {
        characters = characters.filter { character in
            favoritesService.isFavorite(character.id)
        }
    }
}
