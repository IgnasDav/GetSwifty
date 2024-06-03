//
//  CardCell.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/05/2024.
//

import UIKit

class CardCell: UITableViewCell {
    static let identifier = "CardCell"
    
    private let image: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "characters.jpeg")
        iv.tintColor = .label
        return iv
    }()
    
    private let myLabel: UILabel = {
       let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.text = "Error"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with image: UIImage, and label: String) {
        self.image.image = image
        myLabel.text = label
    }
    
    private func setupUI() {
        contentView.addSubview(image)
        contentView.addSubview(myLabel)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 90),
            image.widthAnchor.constraint(equalToConstant: 90),
            myLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
