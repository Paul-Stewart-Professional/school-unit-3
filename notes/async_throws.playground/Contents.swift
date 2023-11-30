import UIKit

import UIKit

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
}

enum PhotoInfoError: Error, LocalizedError {
    case itemNotFound
}

func fetchPhotoInfo() async throws -> PhotoInfo {
    var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
    urlComponents.queryItems = [
        "api_key": "DEMO_KEY",
        "date": "2013-07-16"
    ].map { URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else { throw PhotoInfoError.itemNotFound }
    
    return try JSONDecoder().decode(PhotoInfo.self, from: data)
}


Task {
    do {
        try await fetchPhotoInfo()
    } catch {
        print(error.localizedDescription)
    }
}
