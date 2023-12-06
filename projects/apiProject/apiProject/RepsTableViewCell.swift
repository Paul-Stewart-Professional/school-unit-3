//
//  TableViewCell.swift
//  apiProject
//
//  Created by Paul Stewart on 12/5/23.
//

import UIKit

class RepsTableViewCell: UITableViewCell {

    @IBOutlet weak var websiteLinkButton: UIButton!
    @IBOutlet weak var partyStateLabel: UILabel!
    @IBOutlet weak var repNameLabel: UILabel!
    
    weak var delegate: RepsTableViewCellDelegate?
    var rep: Representative?
    var url: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func websiteLinkButtonTapped(_ sender: Any) {
        delegate?.grabURL(rep: rep!, url: url!)
    }
    
}
