//
//  ContentView.swift
//  Premier League Players
//
//  Created by Kevin Keller on 1/19/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TeamSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchQuery)
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    ErrorView(error: error)
                } else {
                    TeamList(teams: viewModel.filteredTeams)
                }
            }
            .navigationTitle("Premier League Teams")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search teams...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct TeamList: View {
    let teams: [Team]
    
    var body: some View {
        List(teams) { team in
            NavigationLink(destination: TeamDetailView(team: team)) {
                TeamRow(team: team)
            }
        }
        .listStyle(.plain)
    }
}

struct TeamRow: View {
    let team: Team
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: team.crest)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text(team.name)
                    .font(.headline)
                Text(team.venue)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
