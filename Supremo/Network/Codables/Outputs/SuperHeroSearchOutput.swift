//
//  SuperHeroSearchOutput.swift
//  Supremo
//
//  Created by Sharad on 15/11/20.
//

import Foundation

// MARK: - SuperHeroSearchOutput
struct SuperHeroSearchOutput: Codable {
    let response: String
    let resultsFor: String?
    let results: [SearchedResult]

    enum CodingKeys: String, CodingKey {
        case response
        case resultsFor = "results-for"
        case results
    }
}

// MARK: - Result
struct SearchedResult: Codable, Equatable {
    
    static func == (lhs: SearchedResult, rhs: SearchedResult) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id, name: String
    let powerstats: Powerstats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
    let image: Image
}

// MARK: - Appearance
struct Appearance: Codable {
    let gender: String
    let race: String
    let height, weight: [String]
    let eyeColor, hairColor: String

    enum CodingKeys: String, CodingKey {
        case gender, race, height, weight
        case eyeColor  = "eye-color"
        case hairColor = "hair-color"
    }
}

// MARK: - Biography
struct Biography: Codable {
    let fullName: String
    let alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance: String
    let publisher: String
    let alignment: String

    enum CodingKeys: String, CodingKey {
        case fullName        = "full-name"
        case alterEgos       = "alter-egos"
        case aliases
        case placeOfBirth    = "place-of-birth"
        case firstAppearance = "first-appearance"
        case publisher, alignment
    }
}

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation, relatives: String

    enum CodingKeys: String, CodingKey {
        case groupAffiliation = "group-affiliation"
        case relatives
    }
}

// MARK: - Image
struct Image: Codable {
    let url: String
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence, strength, speed, durability: String
    let power, combat: String
}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}
