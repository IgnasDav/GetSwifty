//
//  PillButton.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 01/07/2024.
//

import UIKit

class PillButton: UIButton {
    override func updateConfiguration() {
        guard var configuration = configuration else { return }

        var background = UIButton.Configuration.plain().background
        background.cornerRadius = 20
        background.strokeWidth = 1

        let strokeColor: UIColor
        let foregroundColor: UIColor
        let backgroundColor: UIColor
        let baseColor = configuration.baseBackgroundColor ?? UIColor.tintColor

        switch state {
            case .normal:
                strokeColor = .systemGray5
                foregroundColor = baseColor
                backgroundColor = .clear
            case .selected:
                strokeColor = .clear
                foregroundColor = .white
                backgroundColor = .systemGreen
            default:
                strokeColor = .systemGray5
                foregroundColor = baseColor.withAlphaComponent(0.4)
                backgroundColor = .clear
        }

        background.strokeColor = strokeColor
        background.backgroundColorTransformer = UIConfigurationColorTransformer { _ in
            backgroundColor
        }
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = foregroundColor
            return container
        }
        configuration.background = background
        self.configuration = configuration
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

extension PillButton {
    private func setupUI() {
        setTitle("Error", for: .normal)
    }
}

// MARK: - Events

extension PillButton {
    @objc private func onTouchUpInside() {
        isSelected = !isSelected
    }
}
