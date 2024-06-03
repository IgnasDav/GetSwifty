//
//  Toggle.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 31/05/2024.
//

import UIKit

class AppToggle: UIControl {
    var delegate: ToggleDelegate?
    private let thumb = ThumbView()

    private let leftBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("All", for: .normal)
        btn.backgroundColor = .appLightGray
        return btn
    }()

    private let rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Favorites", for: .normal)
        btn.backgroundColor = .lynch
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        leftBtn.addTarget(self, action: #selector(toggleTouched), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(toggleTouched), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func toggleTouched(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            switch title {
                case CharactersToggleOptions.all.rawValue:
                    leftBtn.backgroundColor = .appLightGray
                    rightBtn.backgroundColor = .lynch
                case CharactersToggleOptions.favorites.rawValue:
                    leftBtn.backgroundColor = .lynch
                    rightBtn.backgroundColor = .appLightGray
                default:
                    return
            }
            delegate?.didToggleChange(with: title)
        }
    }
}

extension AppToggle {
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        thumb.translatesAutoresizingMaskIntoConstraints = false
        leftBtn.translatesAutoresizingMaskIntoConstraints = false
        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
        leftBtn.layer.masksToBounds = true
        leftBtn.layer.cornerRadius = 5
        leftBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        rightBtn.layer.masksToBounds = true
        rightBtn.layer.cornerRadius = 5
        rightBtn.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]

        backgroundColor = .lynch
        addSubview(leftBtn)
        addSubview(rightBtn)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            leftBtn.trailingAnchor.constraint(equalTo: centerXAnchor),
            leftBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftBtn.heightAnchor.constraint(equalTo: heightAnchor, constant: -10),
            leftBtn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -5),
            rightBtn.leadingAnchor.constraint(equalTo: centerXAnchor),
            rightBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightBtn.heightAnchor.constraint(equalTo: heightAnchor, constant: -10),
            rightBtn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -5),
        ])
    }
}
