//
//  ChatDetailTableRightViewCell.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit

class ChatDetailTableRightViewCell: UITableViewCell {

    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleImageView.image = bubbleImageView.image?.withRenderingMode(.alwaysTemplate)
        bubbleImageView.tintColor = UIColor(red: 19/255.0, green: 144/255.0, blue: 255/255.0, alpha: 1)
        messageLabel.textColor = .white()
        
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 15
    }
}
