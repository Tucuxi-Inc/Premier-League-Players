import SwiftUI

struct TeamDetailView: View {
    let team: Team
    @StateObject private var viewModel = TeamDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Team Header
                TeamHeaderView(team: team)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    ErrorView(error: error)
                } else {
                    // Latest Matches Section
                    if !viewModel.matches.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Matches")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.matches) { match in
                                        MatchCard(match: match)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Squad Section
                    if let squad = viewModel.teamDetails?.squad {
                        SquadListView(players: squad)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadTeamDetails(teamId: team.id)
        }
    }
}

struct MatchCard: View {
    let match: Match
    
    var body: some View {
        VStack(spacing: 8) {
            // Match Date
            Text(match.utcDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
            
            // Teams and Score
            HStack(spacing: 20) {
                // Home Team
                VStack {
                    Text(match.homeTeam.name)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    Text("\(match.score.fullTime.home ?? 0)")
                        .font(.title3)
                        .bold()
                }
                
                Text("vs")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Away Team
                VStack {
                    Text(match.awayTeam.name)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    Text("\(match.score.fullTime.away ?? 0)")
                        .font(.title3)
                        .bold()
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
        .frame(width: 200)
    }
}

struct TeamHeaderView: View {
    let team: Team
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: team.crest)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            
            Text(team.name)
                .font(.title)
                .bold()
            
            Text(team.venue)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let colors = team.clubColors {
                Text("Club Colors: \(colors)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

#Preview {
    NavigationView {
        TeamDetailView(team: Team(
            id: 1,
            name: "Arsenal",
            shortName: "ARS",
            tla: "ARS",
            crest: "https://crests.football-data.org/1.png",
            address: "75 Drayton Park London N5 1BU",
            website: "http://www.arsenal.com",
            founded: 1886,
            clubColors: "Red / White",
            venue: "Emirates Stadium",
            lastUpdated: Date()
        ))
    }
} 