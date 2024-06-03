//
//  CardNavigationDelegate.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 01/05/2024.
//

import Foundation

protocol CardNavigationDelegate {
    func didNavigateToCard(name: String) -> Void
}
