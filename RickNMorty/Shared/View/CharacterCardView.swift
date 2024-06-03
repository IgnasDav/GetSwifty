//
//  CharacterCardView.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/05/2024.
//

import UIKit

class CharacterCardView: UIView {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        return iv
    }()
    
   private let textCard: UIView = {
        let uv = UIView()
        uv.backgroundColor = .green
        return uv
    }()
    
   private let text: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func configure(with url: URL) {
        imageView.load(url: url)
    }
}

extension CharacterCardView {
    func createView() {
        translatesAutoresizingMaskIntoConstraints = false
        textCard.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        backgroundColor = .red
        addSubview(textCard)
        textCard.addSubview(text)
        addSubview(imageView)
        text.text = "Hello"
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 280),
            widthAnchor.constraint(equalToConstant: 180),
            textCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            textCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textCard.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: textCard.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            text.centerXAnchor.constraint(equalTo: textCard.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: textCard.centerYAnchor)
        ])
    }
}
