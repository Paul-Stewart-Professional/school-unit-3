import UIKit
import Foundation

struct ReturnedMusic: Codable {
    var artistName: String
    var trackName: String
}

enum networkError: Error {
    case httpStatusCodeError
}
func fetchMusic() async throws -> ReturnedMusic {
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
    urlComponents.queryItems = [
        "term": "j+cole",
        "entity": "music"
    ].map { URLQueryItem(name: $0.key, value: $0.value) }
    urlComponents.queryItems?.append(urlComponents.queryItems)
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else { throw networkError.httpStatusCodeError }
    return try JSONDecoder().decode(ReturnedMusic.self, from: data)
}

Task {
    do {
        try await fetchMusic()
    } catch {
        print(error.localizedDescription)
    }
}
