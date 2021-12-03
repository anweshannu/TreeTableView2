//
//  TreeNodeTableViewCell.swift
//  TreeTableView
//
//  Created by Anwesh M on 01/12/21.
//

import UIKit

class TreeNodeTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var nodeIMG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
        self.layer.masksToBounds = true
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.3
        self.backgroundColor = .none
        self.selectionStyle = .none
        view.layer.cornerRadius = 7
        nameButton.contentHorizontalAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            print("SetSelected...")
        // Configure the view for the selected state
    }
}
