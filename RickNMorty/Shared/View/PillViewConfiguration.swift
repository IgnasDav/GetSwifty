//
//  PillViewConfiguration.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 02/07/2024.
//

import UIKit

public extension UIButton.Configuration {
    static func pill() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = style.background
        background.cornerRadius = 20
        background.strokeWidth = 1
        background.strokeColor = .systemGray5
        style.background = background

        return style
    }
}
