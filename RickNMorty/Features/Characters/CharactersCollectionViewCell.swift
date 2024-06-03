//
//  CharactersCollectionViewCell.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 15/05/2024.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharactersCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
        iv.layer.cornerRadius = 5
        iv.image = UIImage(systemName: "questionmark")
        return iv
    }()
    private let nameTextLine = TextLineViewStack()
    private let genderTextLine = TextLineViewStack()
    private let statusTextLine = TextLineViewStack()
    private let speciesTextLine = TextLineViewStack()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: URL, name: String, gender: String, status: String, species: String) {
        imageView.load(url: url)
        nameTextLine.configure(label: .name, value: name)
        genderTextLine.configure(label: .gender, value: gender)
        statusTextLine.configure(label: .status, value: status)
        speciesTextLine.configure(label: .species, value: species)
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.addSubview(imageView)
        self.addSubview(nameTextLine)
        self.addSubview(genderTextLine)
        self.addSubview(statusTextLine)
        self.addSubview(speciesTextLine)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            
            nameTextLine.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameTextLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameTextLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            genderTextLine.topAnchor.constraint(equalTo: nameTextLine.bottomAnchor, constant: 10),
            genderTextLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            genderTextLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            statusTextLine.topAnchor.constraint(equalTo: genderTextLine.bottomAnchor, constant: 10),
            statusTextLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            statusTextLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            speciesTextLine.topAnchor.constraint(equalTo: statusTextLine.bottomAnchor, constant: 10),
            speciesTextLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            speciesTextLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
