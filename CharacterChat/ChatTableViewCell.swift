//
//  FriendTableViewCell.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Kazuhiro Hayashi All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageSummaryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var imageIdentifier: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 22
    }

}
