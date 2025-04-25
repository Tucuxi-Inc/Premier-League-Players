import SwiftUI

struct LatestMatchView: View {
    let match: Match
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Latest Match")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 20) {
                // Home Team
                VStack {
                    Text(match.homeTeam.name)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    Text("\(match.score.fullTime.home ?? 0)")
                        .font(.title)
                        .bold()
                }
                
                Text("vs")
                    .foregroundColor(.secondary)
                
                // Away Team
                VStack {
                    Text(match.awayTeam.name)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    Text("\(match.score.fullTime.away ?? 0)")
                        .font(.title)
                        .bold()
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
            
            Text(match.utcDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
} 