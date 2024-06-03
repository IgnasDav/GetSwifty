//
//  Character.swift
//  RickNMorty
//
//  Created by Ignas Davulis on 10/05/2024.
//

import Foundation

enum LifeStatus: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
}

enum Gender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct CharactersApi: Codable {
    let info: Info
    let results: [Character]
}
