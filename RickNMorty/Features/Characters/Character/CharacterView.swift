//
//  CharacterView.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 20/05/2024.
//

import UIKit

class CharacterView: UIView {
    var delegate: FavoriteTouchDelegate?
    
    private let nameLabel: UILabel = {
        let ul = UILabel()
        ul.text = "Error"
        ul.font = .systemFont(ofSize: 22, weight: .heavy)
        return ul
    }()

    private let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "questionmark")
        iv.layer.masksToBounds = true
        iv.backgroundColor = .cyan
        return iv
    }()
    
    private let favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        btn.addTarget(self, action: #selector(onFavoriteTap), for: .touchUpInside)
        return btn
    }()
    
    private let genderLabel = TextLineViewStack()
    private let statusLabel = TextLineViewStack()
    private let speciesLabel = TextLineViewStack()
    private let typeLabel = TextLineViewStack()
    private let originLabel = TextLineViewStack()
    private let locationLabel = TextLineViewStack()
    private let episodeLabel = TextLineViewStack()
    private let createdLabel = TextLineViewStack()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onFavoriteTap(sender: UIButton) {
        print("fires")
        delegate?.onFavoriteTap(favoriteButton)
    }
}

// MARK: - Setup UI

extension CharacterView {
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(favoriteButton)
        addSubview(characterImage)
        addSubview(genderLabel)
        addSubview(statusLabel)
        addSubview(speciesLabel)
        addSubview(typeLabel)
        addSubview(originLabel)
        addSubview(locationLabel)
        addSubview(episodeLabel)
        addSubview(createdLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoriteButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 35),
            favoriteButton.widthAnchor.constraint(equalToConstant: 35),
            characterImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            characterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImage.widthAnchor.constraint(equalToConstant: 200),
            characterImage.heightAnchor.constraint(equalToConstant: 200),
            
            genderLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 40),
            genderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            genderLabel.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            speciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            speciesLabel.heightAnchor.constraint(equalToConstant: 40),
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            typeLabel.heightAnchor.constraint(equalToConstant: 40),
            createdLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            createdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            createdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            createdLabel.heightAnchor.constraint(equalToConstant: 40),
            episodeLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 10),
            episodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            episodeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            episodeLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        characterImage.layoutIfNeeded()
        characterImage.layer.cornerRadius = characterImage.frame.width / 2
        genderLabel.makeToPill()
        statusLabel.makeToPill()
        speciesLabel.makeToPill()
        typeLabel.makeToPill()
        episodeLabel.makeToPill()
        createdLabel.makeToPill()
    }
}

// MARK: - Configure method

extension CharacterView {
    func configure(with character: Character) {
        characterImage.load(url: URL(string: character.image)!)
        nameLabel.text = character.name
        genderLabel.configure(label: .gender, value: character.gender)
        statusLabel.configure(label: .status, value: character.status)
        speciesLabel.configure(label: .species, value: character.species)
        typeLabel.configure(label: .type, value: character.type)
        episodeLabel.configure(label: .episode, value: character.episode.description)
        createdLabel.configure(label: .created, value: character.created)
    }
}

extension CharacterView {
    func toggleFavorite(_ isFavorite: Bool) {
        isFavorite ? favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal) : favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
    }
}
