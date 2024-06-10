//
//  ModalDelegate.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 28/06/2024.
//

import Foundation

@objc protocol ModalDelegate: AnyObject {
    @objc optional func presentModal(data: AnyObject) -> Void

    @objc optional func onCloseEvent() -> Void
}
