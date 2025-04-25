import Foundation

struct Match: Codable, Identifiable {
    let id: Int
    let utcDate: Date
    let status: String
    let stage: String
    let homeTeam: TeamInMatch
    let awayTeam: TeamInMatch
    let score: Score
    
    struct TeamInMatch: Codable {
        let id: Int
        let name: String
        let shortName: String?
        let tla: String?
        let crest: String?
    }
    
    struct Score: Codable {
        let winner: String?
        let duration: String
        let fullTime: ScoreDetails
        let halfTime: ScoreDetails
        
        struct ScoreDetails: Codable {
            let home: Int?
            let away: Int?
        }
    }
}

struct MatchesResponse: Codable {
    let matches: [Match]
    let resultSet: ResultSet
    
    struct ResultSet: Codable {
        let count: Int
        let competitions: String
        let first: String
        let last: String
        let played: Int
    }
} 