//
//  ToggleDelegate.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 04/06/2024.
//

import Foundation

protocol ToggleDelegate {
    func didToggleChange(with text: String) -> Void
}
