//
//  ChatDetailTableViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit

class ChatDetailTableViewController: UITableViewController {

    var messages = [
        "ああああああああああああああああああああああああああああああああああああああああああああああああああああああ",
        "いいい",
        "うううううううううううううううううううううううううううううううううううううううううう",
        "えええええええええええええええええええ",
        "おおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおお",
        "いｆでゃおひｆどあいｆでゃひｆｄぱｈｄｆぽあひおｄふぁｄふぁｓ",
        "あああ",
        "あああ",
        "あ",
        "あ"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDetailTableViewCell", for: indexPath) as! ChatDetailTableViewCell
            cell.messageLabel.text = messages[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDetailTableRightViewCell", for: indexPath) as! ChatDetailTableRightViewCell
            cell.messageLabel.text = messages[indexPath.row]
            return cell
        }
    }


}
