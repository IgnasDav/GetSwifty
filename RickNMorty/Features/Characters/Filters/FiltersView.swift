//
//  FiltersView.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/06/2024.
//

import UIKit

class FiltersView: UIView {
    private let button: UIButton = {
        let btn = UIButton(configuration: .plain())
        btn.setTitle("Close", for: .normal)
        btn.addTarget(self, action: #selector(onCloseTouch), for: .touchUpInside)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()

    private let pillButton: PillButton = .init()
    private let statusFiltersView: FilterParametersView = .init()

    weak var delegate: ModalDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

extension FiltersView {
    private func setupUI() {
        button.translatesAutoresizingMaskIntoConstraints = false
        statusFiltersView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        addSubview(statusFiltersView)
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 30),
            statusFiltersView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            statusFiltersView.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusFiltersView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusFiltersView.heightAnchor.constraint(equalToConstant: 100),
        ])

        // This would need to be extracted into function as it will be reused
        statusFiltersView.initialize(header: "Life status", views: StatusFilters.allCases.map {
            let btn = PillButton(configuration: .filled())
            btn.setTitle($0.rawValue, for: .normal)
            return btn
        })
    }
}

// MARK: - Delegation events

extension FiltersView {
    @objc private func onCloseTouch() {
        delegate?.onCloseEvent?()
    }
}
