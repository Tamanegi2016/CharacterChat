//
//  CharacterPartsViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit

class CharacterPartsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var menu: [(title: String, color: UIColor)] = [
        (title: "まゆげ", color: #colorLiteral(red: 0.8100712299, green: 0.1511939615, blue: 0.4035313427, alpha: 1)),
        (title: "目", color: #colorLiteral(red: 0.2856909931, green: 0, blue: 0.9589199424, alpha: 1)),
        (title: "鼻", color: #colorLiteral(red: 0.9346159697, green: 0.6284804344, blue: 0.1077284366, alpha: 1)),
        (title: "目", color: #colorLiteral(red: 0.6707916856, green: 0.8720328808, blue: 0.5221258998, alpha: 1))
    ]
    
    var selectVC: CharacterPartsSelectViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterPartsViewCell", for: indexPath) as! CharacterPartsViewCell
        cell.menuLabel.text = menu[indexPath.row].title
        cell.backgroundColor = menu[indexPath.row].color
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectVC?.dataSet = []
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / CGFloat(menu.count), height: view.bounds.height)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? CharacterPartsSelectViewController {
            selectVC = vc
        }
    }
}
