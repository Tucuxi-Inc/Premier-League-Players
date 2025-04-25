import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    case apiError(String)
}

class APIClient {
    // Football-Data.org base URL
    private let baseURL = "https://api.football-data.org/v4"
    private let apiKey = "5aeb0b5dc4f946aeadf58eefec5f8666"
    
    static let shared = APIClient()
    private init() {}
    
    private let session = URLSession.shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    // Get Premier League teams (PL is the competition code for Premier League)
    func getTeams() async throws -> [Team] {
        let endpoint = "/competitions/PL/teams"
        let response: TeamsResponse = try await performRequest(endpoint: endpoint)
        return response.teams
    }
    
    // Get team details including squad
    func getTeamDetails(teamId: Int) async throws -> TeamDetails {
        let endpoint = "/teams/\(teamId)"
        return try await performRequest(endpoint: endpoint)
    }
    
    // Get team's most recent matches
    func getTeamMatches(teamId: Int, limit: Int = 5) async throws -> [Match] {
        let endpoint = "/teams/\(teamId)/matches?status=FINISHED&limit=\(limit)"
        let response: MatchesResponse = try await performRequest(endpoint: endpoint)
        return response.matches.sorted { $0.utcDate > $1.utcDate }
    }
    
    private func performRequest<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                // Try to decode error message if available
                if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                    throw APIError.apiError(errorResponse.message)
                }
                throw APIError.invalidResponse
            }
            
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
}

struct APIErrorResponse: Codable {
    let message: String
} 