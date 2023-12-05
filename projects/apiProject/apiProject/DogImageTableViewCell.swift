//
//  DogImageTableViewCell.swift
//  apiProject
//
//  Created by Paul Stewart on 12/2/23.
//

import UIKit

class DogImageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    
    func update(with url: URL) {
        Task {
            do {
                let data = try await getImageData(from: url)
                guard let image = UIImage(data: data) else {
                    throw DogError.imageData
                }
                dogImageView.image = image
                let size = image.size
                print(size.height)
            } catch {
                print("There was an error, \(error.localizedDescription)")
            }
        }
    }
    
    private func getImageData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}
