//
//  ViewController.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/06/2024.
//

import UIKit

class FiltersViewController: UIViewController {
    private let filtersView = FiltersView()

    override func viewDidLoad() {
        super.viewDidLoad()
        filtersView.delegate = self
        setupUI()
    }
}

// MARK: - Setup UI

extension FiltersViewController {
    private func setupUI() {
        filtersView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filtersView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            filtersView.topAnchor.constraint(equalTo: view.topAnchor),
            filtersView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filtersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filtersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }

    @objc private func hello() {}
}

// MARK: - Modal close delegate

extension FiltersViewController: ModalDelegate {
    func onCloseEvent() {
        dismiss(animated: true)
    }
}
