//
//  CardView.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 07/05/2024.
//

import UIKit

class CardView: UIView {
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.font = .monospacedSystemFont(ofSize: 34, weight: .heavy)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -Setup view

extension CardView {
    func createView() {
        layer.cornerRadius = 15
        addToSubview()
        translateComponentAutoresizing()
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 220),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
}

//MARK: -Set translateAutoResizingMaskIntoConstraints

extension CardView {
    func translateComponentAutoresizing() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: -Add components to subview

extension CardView {
    func addToSubview() {
        addSubview(imageView)
        addSubview(label)
    }
}
