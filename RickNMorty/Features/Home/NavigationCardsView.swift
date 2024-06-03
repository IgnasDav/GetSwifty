//
//  NavigationCardsView.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/05/2024.
//

import UIKit

class NavigationCardsView: UIStackView {
    private let charactersCardController = CardController()
    private let episodesCardController = CardController()
    private let locationsCardController = CardController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .equalCentering
        addArrangedSubview(charactersCardController.view)
        charactersCardController.configure(with: UIImage(named: "characters.jpeg"), label: "Characters")
        addArrangedSubview(episodesCardController.view)
        episodesCardController.configure(with: UIImage(named: "episodes.jpeg"), label: "Episodes")
        addArrangedSubview(locationsCardController.view)
        locationsCardController.configure(with: UIImage(named: "locations.jpeg"), label: "Locations")
        alignment = .top
    }
    
    func configure(delegate: CardNavigationDelegate) {
        charactersCardController.delegate = delegate
        locationsCardController.delegate = delegate
        episodesCardController.delegate = delegate
    }
}
