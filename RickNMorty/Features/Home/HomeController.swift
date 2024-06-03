//
//  HomeController.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 26/04/2024.
//

import UIKit

class HomeController: UIViewController {
    private let characterController = CardController()
    private let navigationCardView = NavigationCardsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        createView()
    }
}

extension HomeController: CardNavigationDelegate {
    func didNavigateToCard(name: String) {
        switch name {
            case "Characters":
                let charactersController = CharactersContoller()
                navigationController?.pushViewController(charactersController, animated: true)
            case "Episodes":
                let episodesController = EpisodesViewController()
                navigationController?.pushViewController(episodesController, animated: true)
            case "Locations":
                let locationsController = LocationsViewController()
                navigationController?.pushViewController(locationsController, animated: true)
            default:
                return
        }
    }
}

extension HomeController {
    func createView() {
        view.addSubview(navigationCardView)
        navigationCardView.configure(delegate: self)
        NSLayoutConstraint.activate([
            navigationCardView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            navigationCardView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0),
            navigationCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            navigationCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }
}
