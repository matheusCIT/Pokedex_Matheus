import Foundation

struct PokemonDetailsResponse: Codable {
    let abilities: [AbilityResponse]
    let baseExperience: Int
    let height: Int
    let id: Int
    let moves: [MoveResponse]
    let name: String
    let sprites: Dictionary<String,String?>
    let stats: [StatResponse]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height
        case id
        case moves, name, sprites, stats, weight
    }
}

struct AbilityResponse: Codable {
    let ability: Details
    let isHidden: Bool

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
    }
}

struct Details: Codable {
    let name: String
}

struct MoveResponse: Codable {
    let move: Details
}

struct StatResponse: Codable {
    let baseStat: Int
    let effort: Int
    let stat: Details

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

