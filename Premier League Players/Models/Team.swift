import Foundation

struct Team: Codable, Identifiable {
    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let crest: String
    let address: String
    let website: String
    let founded: Int?
    let clubColors: String?
    let venue: String
    let lastUpdated: Date
    
    // For search/filtering
    var matchesSearchTerm: (String) -> Bool {
        { searchTerm in
            let searchable = [name, shortName, tla].joined(separator: " ").lowercased()
            return searchable.contains(searchTerm.lowercased())
        }
    }
}

struct TeamsResponse: Codable {
    let count: Int
    let filters: [String: String]
    let competition: Competition
    let season: Season
    let teams: [Team]
}

struct Competition: Codable {
    let id: Int
    let name: String
    let code: String
    let type: String
    let emblem: String
}

struct Season: Codable {
    let id: Int
    let startDate: String
    let endDate: String
    let currentMatchday: Int?
    let winner: Team?
}

struct TeamDetails: Codable {
    let id: Int
    let name: String
    let squad: [Player]
    let coach: Coach
    let venue: String
    let runningCompetitions: [Competition]
}

struct Coach: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let name: String
    let dateOfBirth: String
    let nationality: String
    let contract: Contract
}

struct Contract: Codable {
    let start: String
    let until: String
} 