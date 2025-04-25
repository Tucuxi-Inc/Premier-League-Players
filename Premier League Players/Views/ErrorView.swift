import SwiftUI

struct ErrorView: View {
    let error: Error
    
    var errorMessage: String {
        switch error {
        case APIError.apiError(let message):
            return message
        case APIError.invalidResponse:
            return "The server returned an invalid response. Please try again."
        case APIError.networkError:
            return "There was a problem connecting to the server. Please check your internet connection."
        case APIError.decodingError:
            return "There was a problem processing the data. Please try again."
        default:
            return error.localizedDescription
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("Something went wrong")
                .font(.headline)
            
            Text(errorMessage)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                // You can add a retry action here if needed
            }) {
                Text("Try Again")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
} 