//
//  CharacterContoller.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 26/04/2024.
//

import UIKit

class CharactersContoller: UIViewController {
    private let viewModel = CharactersViewModel()
    private let collectionView = CharactersCollectionView()
    private let searchField: UISearchTextField = {
        let tf = UISearchTextField()
        tf.placeholder = "Search for character"
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        collectionView.dataSource = self
        collectionView.delegate = self
        searchField.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(onDisplayFilters))

        viewModel.onCharactersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        viewModel.onCharactersError = { [weak self] error in
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

            DispatchQueue.main.async {
                alert.title = "Error happened"
                alert.message = String(describing: error)
            }
        }
    }

    @objc private func onDisplayFilters() {
        present(FiltersViewController(), animated: true, completion: nil)
    }
}

// MARK: - Create UI

extension CharactersContoller {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(searchField)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            searchField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - Collection view delegate

extension CharactersContoller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as? CharactersCollectionViewCell else {
            fatalError("Failed to dequeue CharactersCollectionViewCell in Characters controller")
        }

        let character = viewModel.characters[indexPath.row]

        if let url = URL(string: character.image) {
            cell.configure(with: url, name: character.name, gender: character.gender, status: character.status, species: character.species)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CharacterViewController()
        vc.character = viewModel.characters[indexPath.row]
        present(vc, animated: true)
    }
}

// MARK: - Flow layout delegate

extension CharactersContoller: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width / 2) - 16
        return CGSize(width: size, height: 260)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

// MARK: - Toggle delegate

extension CharactersContoller: ToggleDelegate {
    func didToggleChange(with text: String) {
        viewModel.filterCharactersByFavoritesToggle(type: text)
    }
}

// MARK: - Text field delegate

extension CharactersContoller: UISearchTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("hej")
    }
}
