import Foundation
import Combine

@MainActor
class TeamSearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var allTeams: [Team] = []
    @Published var filteredTeams: [Team] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private var searchCancellable: AnyCancellable?
    
    init() {
        setupSearch()
        Task {
            await loadTeams()
        }
    }
    
    private func setupSearch() {
        searchCancellable = $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.filterTeams(query: query)
            }
    }
    
    private func loadTeams() async {
        isLoading = true
        error = nil
        
        do {
            allTeams = try await APIClient.shared.getTeams()
            filterTeams(query: searchQuery)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    private func filterTeams(query: String) {
        if query.isEmpty {
            filteredTeams = allTeams
        } else {
            filteredTeams = allTeams.filter { $0.matchesSearchTerm(query) }
        }
    }
} 