//
//  EpisodesViewController.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/05/2024.
//

import UIKit

class EpisodesViewController: UIViewController {
    private let imageView: UIImageView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        // Do any additional setup after loading the view.
    }
}
