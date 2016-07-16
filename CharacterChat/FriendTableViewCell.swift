//
//  FriendTableViewCell.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 22
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
