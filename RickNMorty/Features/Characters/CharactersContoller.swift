//
//  CharacterContoller.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 26/04/2024.
//

import UIKit

class CharactersContoller: UIViewController {
    let viewModel = CharactersViewModel()
    private let collectionView = CharactersCollectionView()
    private var isFilterHidden = true {
        didSet {
            toggleView.isHidden = isFilterHidden
        }
    }

    private let toggleView: AppToggle = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        collectionView.dataSource = self
        collectionView.delegate = self
        toggleView.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(toggleFilterView))

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

    @objc private func toggleFilterView() {
        isFilterHidden.toggle()
    }
}

// MARK: - Create UI

extension CharactersContoller {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(toggleView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.isHidden = true

        NSLayoutConstraint.activate([
            toggleView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            toggleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: toggleView.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
