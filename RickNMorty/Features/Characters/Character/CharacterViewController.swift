//
//  CharacterViewController.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 20/05/2024.
//

import UIKit

// There should be a long toggle a the top to only show favorites or no!
class CharacterViewController: UIViewController {
    private let characterView = CharacterView()
    private let viewModel = CharacterViewModel()

    private var character: Character? {
        didSet {
            viewModel.setCharacter(character)
            // This should be refactored
            characterView.configure(with: character!)
            characterView.toggleFavorite(viewModel.getIsFavorite())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setCharacter(_ character: Character) {
        self.character = character
    }
}

// MARK: - Setup UI

extension CharacterViewController {
    private func setupUI() {
        characterView.delegate = self
        viewModel.favoritesService.delegate = self
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characterView)
        NSLayoutConstraint.activate([
            characterView.heightAnchor.constraint(equalTo: view.heightAnchor),
            characterView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}

// MARK: - Favorite touch delegate

extension CharacterViewController: FavoriteTouchDelegate {
    func onFavoriteTap(_ sender: Any?) {
        viewModel.toggleFavorite(id: character?.id)
    }

    func didFavoriteSet(isFavorite: Bool) {
        characterView.toggleFavorite(isFavorite)
    }
}
