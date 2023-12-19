
import UIKit

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try?
                JSONSerialization.jsonObject(with: self,
                                             options: []),
            let jsonData = try?
                JSONSerialization.data(withJSONObject:
                                        jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData,
                                          encoding: .utf8) else {
            print("Failed to read JSON Object.")
            return
        }
        print(prettyJSONString)
    }
}

struct StoreItem: Codable {
    var kind: String
    var artWorkUrl: String
    var artistName: String
    var trackName: String
    var primaryGenreName: String
    var description: String?
    
    
    enum CodingKeys: String, CodingKey {
        case kind
        case artWorkUrl = "artworkUrl100"
        case artistName
        case trackName
        case primaryGenreName
        case description
    }
    enum AdditionalCodingKeys: CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artWorkUrl = try values.decode(String.self, forKey: CodingKeys.artWorkUrl)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        primaryGenreName = try values.decode(String.self, forKey: CodingKeys.primaryGenreName)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalCodingKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalCodingKeys.longDescription)) ?? ""
        }
    }
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}

enum error: Error, LocalizedError {
    case non200StatusCode
    
}

func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
    urlComponents.queryItems = query.map( { URLQueryItem(name: $0.key, value: $0.value ) } )
    let (data, response) = try await
    URLSession.shared.data(from: urlComponents.url!)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else { throw error.non200StatusCode}
    let jsonDecoder = JSONDecoder()
    let searchRequest = try jsonDecoder.decode(SearchResponse.self, from: data)
    return searchRequest.results
}


var queryItems: [String: String] = ["term": "kendrick+lamar", "media": "music", "limit": "5"]

Task {
    do {
        let storeItems = try await fetchItems(matching: queryItems)
        storeItems.forEach { item in
            print("""
            Name: \(item.trackName)
            Artist(s): \(item.artistName)
            Kind: \(item.kind)
            Genre: \(item.primaryGenreName)
            Description: \(item.description ?? "")
            Artwork URL: \(item.artWorkUrl)
            """)
        }
    } catch {
        print(error)
    }
}
