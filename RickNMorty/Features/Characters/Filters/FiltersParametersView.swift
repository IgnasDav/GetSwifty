//
//  FiltersParametersView.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 01/07/2024.
//

import UIKit

class FilterParametersView: UIStackView {
    private let header: UILabel = {
        let label = UILabel()
        label.text = "Testing"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let hStack: UIStackView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

extension FilterParametersView {
    private func setupUI() {
        axis = .vertical
        alignment = .leading
        hStack.alignment = .leading
        spacing = 20
        hStack.spacing = 20
        addArrangedSubview(header)
        addArrangedSubview(hStack)
    }

    func addViewToHStack(_ view: UIView) {
        hStack.addArrangedSubview(view)
    }

    func initialize(header: String, views: [some UIView]) {
        self.header.text = header
        for view in views {
            addViewToHStack(view)
        }
    }
}
