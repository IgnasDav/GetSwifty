//
//  EpisodesViewController.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/05/2024.
//

import UIKit

class EpisodesViewController: UIViewController {
    private let imageView: UIImageView = .init()
    private let spinner = CardsLoaderViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
}
