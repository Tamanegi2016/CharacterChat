//
//  CharacterPartsSelectViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit


class CharacterPartsSelectViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // TODO:- 表示させるデータを後で定義
    var dataSet = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterPartsSelectViewCell", for: indexPath)
    
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        let horizontalMargin =
            collectionViewLayout.minimumInteritemSpacing + collectionViewLayout.sectionInset.left + collectionViewLayout.sectionInset.right
        let verticalMargin =
            collectionViewLayout.minimumLineSpacing + collectionViewLayout.sectionInset.top + collectionViewLayout.sectionInset.bottom
        return CGSize(width: (collectionView.bounds.width - horizontalMargin) / 2, height: (collectionView.bounds.height - verticalMargin) / 2)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
