//
//  CharacterSelectViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit

class CharacterSelectViewController: UIViewController {
    var selectVC: CharacterPartsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? CharacterPartsViewController {
            selectVC = vc
        }
    }
}
