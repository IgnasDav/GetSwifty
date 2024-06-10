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
    private var _characters: [Character] = [] {
        didSet {
            charactersToDisplay = _characters
        }
    }

    private(set) var charactersToDisplay: [Character] = [] {
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
                    self?._characters = characters
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

    func searchCharacters(by query: String) {
        if query.isEmpty {
            charactersToDisplay = _characters
        } else {
            charactersToDisplay = _characters.filter { character in
                character.name.lowercased().contains(query.lowercased())
            }
        }
    }

    private func filterCharactersByFavorites() {
        charactersToDisplay = charactersToDisplay.filter { character in
            favoritesService.isFavorite(character.id)
        }
    }
}
