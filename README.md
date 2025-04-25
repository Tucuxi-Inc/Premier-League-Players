# Premier League Players App

## Description

This is a simple iOS/macOS application built with SwiftUI that allows users to browse and search for Premier League football teams. It fetches team data, including names, crests, and venues, and displays them in a searchable list.

## Features

*   **Team Listing:** Displays a list of Premier League teams.
*   **Team Details:** Shows team name, crest (logo), and venue in the list.
*   **Search Functionality:** Allows users to filter the list by team name using a search bar.
*   **Asynchronous Image Loading:** Loads team crests efficiently from URLs.
*   **Loading & Error States:** Provides visual feedback during data fetching and displays errors if they occur.
*   **Navigation:** Tapping a team navigates to a detail view (implementation not shown in `ContentView`).

## Structure

The application follows the Model-View-ViewModel (MVVM) design pattern:

*   **Models:** (`Models/`) Define the data structures (e.g., `Team`).
*   **Views:** (`Views/`, `ContentView.swift`) Define the UI elements and layout using SwiftUI. Key views include `ContentView`, `SearchBar`, `TeamList`, and `TeamRow`.
*   **ViewModels:** (`ViewModels/`) Contain the presentation logic and state management (e.g., `TeamSearchViewModel`), fetching data and preparing it for the Views.
*   **Networking:** (`Networking/`) Likely handles the API calls to fetch team data (specific implementation details would be in this folder).
*   **App Entry:** (`Premier_League_PlayersApp.swift`) The main application entry point.

## Setup & Usage

1.  **Prerequisites:** Ensure you have Xcode installed on your macOS machine.
2.  **Clone the Repository:**
    ```bash
    git clone <your-repository-url>
    cd PremierLeague
    ```
3.  **Open the Project:** Open the `Premier League Players.xcodeproj` file located within the `Premier League Players` directory using Xcode.
    ```bash
    open "Premier League Players/Premier League Players.xcodeproj"
    ```
4.  **Select Target:** Choose a simulator or a connected device in Xcode.
5.  **Run the App:** Click the "Run" button (▶) in Xcode or press `Cmd + R`.

The app should launch, fetch the team data, and display the list. You can use the search bar at the top to filter the teams.

## Potential Future Enhancements

*   Implement the `TeamDetailView` to show more information about a selected team (e.g., players, history, website).
*   Add error handling for image loading failures.
*   Implement caching for fetched data to improve performance and reduce API calls.
*   Add unit and UI tests.
*   Improve UI/UX design.
*   Allow sorting or different filtering options. 