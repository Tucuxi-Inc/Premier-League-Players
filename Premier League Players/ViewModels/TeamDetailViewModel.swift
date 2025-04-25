import Foundation

@MainActor
class TeamDetailViewModel: ObservableObject {
    @Published var teamDetails: TeamDetails?
    @Published var matches: [Match] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    func loadTeamDetails(teamId: Int) async {
        isLoading = true
        error = nil
        
        do {
            async let detailsTask = APIClient.shared.getTeamDetails(teamId: teamId)
            async let matchesTask = APIClient.shared.getTeamMatches(teamId: teamId, limit: 5)
            
            let (details, matches) = try await (detailsTask, matchesTask)
            self.teamDetails = details
            self.matches = matches
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
} 