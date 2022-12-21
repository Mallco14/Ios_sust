//
//  HomeTableViewCell.swift
//
//
//
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionPost: UILabel!
    @IBOutlet weak var titlePost: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
