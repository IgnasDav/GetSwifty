//
//  ThumbView.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 31/05/2024.
//

import UIKit

class ThumbView: UIView {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThumbView {
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        drawCircle()
    }

    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30))
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.red.cgColor)

            let rectangle = CGRect(x: 0, y: 0, width: 30, height: 30)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .eoFill)
        }
        imageView.image = img
    }
}
