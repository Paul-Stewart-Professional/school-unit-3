
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
    var type: String
    var artWorkUrl: String
    var artistName: String
    var trackName: String
    var primaryGenre: String
    var description: String?
    
    
    enum CodingKeys: CodingKeys {
        case type
        case artworkUrl = "artworkUrl100"
        case artistName
        case trackName
        case primaryGenreName
        case desctiption
    }
    enum AdditionalCodingKeys: CodingKeys {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: CodingKeys.type)
        artworkUrl = try values.decode(String.self, forKey: CodingKeys.artworkUrl)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        genre = try values.decode(String.self, forKey: CodingKeys.primaryGenreName)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.desctiption) {
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

}


var queryDictionary: [String: String] = ["term": "apple", "media": "music", "limit": "5"]
//var baseURL = URL(from: "https://itunes.apple.com/search")
urlComponents.queryItems = queryDictionary.map( { URLQueryItem(name: $0.key, value: $0.value ) } )
Task {
    let (data, response) = try await
    URLSession.shared.data(from: urlComponents.url!)
    if let httpResponse = response as? HTTPURLResponse,
       //This straight up might not work
       //     let prettyPrintedData = data.prettyPrintedJSONString(),
        httpResponse.statusCode == 200 {
        data.prettyPrintedJSONString()
    }
}
