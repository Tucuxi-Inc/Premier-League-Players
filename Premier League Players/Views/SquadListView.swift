import SwiftUI

struct SquadListView: View {
    let players: [Player]
    
    var groupedPlayers: [String: [Player]] {
        Dictionary(grouping: players) { player in
            player.position ?? "Unknown"
        }
    }
    
    var sortedPositions: [String] {
        let positionOrder = ["Goalkeeper", "Defender", "Midfielder", "Attacker"]
        return positionOrder.filter { groupedPlayers.keys.contains($0) }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Squad")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(sortedPositions, id: \.self) { position in
                VStack(alignment: .leading, spacing: 8) {
                    Text(position)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ForEach(groupedPlayers[position] ?? []) { player in
                        NavigationLink(destination: PlayerDetailView(player: player)) {
                            PlayerRow(player: player)
                        }
                    }
                }
            }
        }
    }
}

struct PlayerRow: View {
    let player: Player
    
    var body: some View {
        HStack {
            Text(player.name)
                .font(.body)
            
            Spacer()
            
            Text(player.nationality)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
} 