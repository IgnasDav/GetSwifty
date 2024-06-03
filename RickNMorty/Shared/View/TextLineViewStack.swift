//
//  TextLineViewStack.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 17/05/2024.
//

import UIKit

class TextLineViewStack: UIStackView {
    private let leftText: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 12, weight: .heavy)
        return text
    }()
    
    private let rightText: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 12, weight: .medium)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(label: TextLineLabel, value: String) {
        leftText.text = label.rawValue
        rightText.text = value
    }
}

extension TextLineViewStack {
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        leftText.translatesAutoresizingMaskIntoConstraints = false
        rightText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(leftText)
        self.addArrangedSubview(rightText)
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
    }
}

extension TextLineViewStack {
    func makeToPill() {
        backgroundColor = UIColor(red: 255/255.0, green: 250/255.0, blue: 160/255.0, alpha: 255)
        layer.cornerRadius = 15
        leftText.font = .systemFont(ofSize: 20, weight: .heavy)
        rightText.font = .systemFont(ofSize: 20)
        layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        isLayoutMarginsRelativeArrangement = true
    }
}
