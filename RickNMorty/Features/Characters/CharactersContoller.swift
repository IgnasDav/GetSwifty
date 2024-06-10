//
//  CharacterContoller.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 26/04/2024.
//

import Combine
import UIKit

class CharactersContoller: UIViewController {
    private let viewModel = CharactersViewModel()
    private let collectionView = CharactersCollectionView()

    private let searchBarController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search characters"
        return sc
    }()

    private var cancellables = [AnyCancellable]()

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBarController.delegate = self
        searchBarController.searchResultsUpdater = self

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

    override func viewDidAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    @objc private func onDisplayFilters() {
        present(FiltersViewController(), animated: true, completion: nil)
    }
}

// MARK: - Create UI

extension CharactersContoller {
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(onDisplayFilters))
        navigationItem.searchController = searchBarController
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - Collection view delegate

extension CharactersContoller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.charactersToDisplay.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as? CharactersCollectionViewCell else {
            fatalError("Failed to dequeue CharactersCollectionViewCell in Characters controller")
        }

        let character = viewModel.charactersToDisplay[indexPath.row]

        if let url = URL(string: character.image) {
            cell.configure(with: url, name: character.name, gender: character.gender, status: character.status, species: character.species)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CharacterViewController()
        vc.setCharacter(viewModel.charactersToDisplay[indexPath.row])
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

// MARK: - UISearchController delegate && UISearchResult updating

extension CharactersContoller: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        if let query = searchController.searchBar.text {
            NotificationCenter.default.publisher(
                for: UITextField.textDidChangeNotification,
                object: searchController.searchBar.searchTextField
            )
            .map { ($0.object as! UITextField).text ?? "" }
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { self.viewModel.searchCharacters(by: $0) }
            .store(in: &cancellables)
        }
    }
}
