
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


var queryDictionary: [String: String] = ["term": "j+cole", "media": "music", "limit": "5"]
//var baseURL = URL(from: "https://itunes.apple.com/search")
var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
urlComponents.queryItems = queryDictionary.map( { URLQueryItem(name: $0.key, value: $0.value ) } )
Task {
  let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
  if let httpResponse = response as? HTTPURLResponse,
     //This straight up might not work
     let prettyPrintedData = data.prettyPrintedJSONString(),
    httpResponse.statusCode == 200,
     //if it doesnt work remove line 31 and replaced prettyPrintedData with data
     let string = String(data: prettyPrintedData, encoding: .utf8) {
    print(string)
  }
}
