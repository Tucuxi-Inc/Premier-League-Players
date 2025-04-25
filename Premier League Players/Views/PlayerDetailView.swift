import SwiftUI

struct PlayerDetailView: View {
    let player: Player
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Player Info
                VStack(spacing: 12) {
                    Text(player.name)
                        .font(.title)
                        .bold()
                    
                    if let position = player.position {
                        Text(position)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("Nationality: \(player.nationality)")
                        .font(.subheadline)
                    
                    Text("Date of Birth: \(player.dateOfBirth ?? "Unknown")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Stats graph will go here later
                Text("Player stats coming soon...")
                    .foregroundColor(.secondary)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
} 