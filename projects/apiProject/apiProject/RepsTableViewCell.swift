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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
