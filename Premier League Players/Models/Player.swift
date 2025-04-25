import Foundation

struct Player: Codable, Identifiable {
    let id: Int
    let name: String
    let position: String?
    let dateOfBirth: String?
    let nationality: String
    
    struct Stats: Codable, Identifiable, Hashable {
        var id: Int { matchId }
        let minutes: Int?
        let goals: Int?
        let assists: Int?
        let tackles: Int?
        let shots: Int?
        let passes: Int?
        let matchId: Int
        let date: Date
        
        enum CodingKeys: String, CodingKey {
            case minutes, goals, assists, tackles, shots, passes
            case matchId = "match_id"
            case date
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(matchId)
        }
        
        static func == (lhs: Stats, rhs: Stats) -> Bool {
            lhs.matchId == rhs.matchId
        }
    }
    
    var recentStats: [Stats]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, position, nationality
        case dateOfBirth = "date_of_birth"
        case recentStats = "recent_stats"
    }
} 