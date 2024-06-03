//
//  FavoriteTouchDelegate.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 23/05/2024.
//

import Foundation

protocol FavoriteTouchDelegate {
    func onFavoriteTap(_ sender: Any?) -> Void
    func didFavoriteSet(isFavorite: Bool) -> Void
}
