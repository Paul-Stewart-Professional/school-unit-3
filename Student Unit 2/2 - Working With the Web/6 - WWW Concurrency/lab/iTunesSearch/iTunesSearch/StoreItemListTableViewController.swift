
import UIKit

class StoreItemListTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    // add item controller property
    
    let controller = StoreItemController()
    
    var items = [StoreItem]()
    
    var storedImage: UIImage?
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    enum ImageError: Error, LocalizedError {
        case imageDataRetrievalError
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchImage(with imageUrl: URL, completion: @escaping (UIImage?) -> Void) {
        Task {
            do {
                let data = try await controller.getImageData(from: imageUrl)
                guard let image = UIImage(data: data) else {
                    throw ImageError.imageDataRetrievalError
                }
                //                completion(image)
                
            } catch {
                // otherwise, print an error to the console
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            // set up query dictionary
            var queryItems: [String: String] = [
                "term": searchTerm,
                "media": mediaType,
                "limit": "10",
                "lang": "en_us"
            ]
            Task {
                do {
                    // use the item controller to fetch items
                    let storeItems = try await controller.fetchItems(matching: queryItems)
                    // if successful, use the main queue to set self.items and reload the table view
                    self.items = storeItems
                    tableView.reloadData()
                } catch {
                    // otherwise, print an error to the console
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    func configure(cell: ItemCell, forItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        // Set cell.titleLabel to the item's name
        cell.titleLabel.text = item.trackName
        
        // Set cell.detailLabel to the item's artist
        cell.detailLabel.text = item.artistName
        
        // Set cell.itemImageView to nil initially
        cell.itemImageView.image = nil
        
        // Initialize a network task to fetch the item's artwork
        if let imageUrl = URL(string: item.artWorkUrl) {
            fetchImage(with: imageUrl) { image in
                // If successful, use the main queue to set the cell's image view's image
                DispatchQueue.main.async {
                    cell.itemImageView.image = image
                }
            }
        }
        
        
        
        // if successful, use the main queue capture the cell, to initialize a UIImage, and set the cell's image view's image to the
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemCell
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}

