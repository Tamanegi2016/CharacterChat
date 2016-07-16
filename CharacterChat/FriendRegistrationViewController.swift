//
//  FriendRegistrationViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit

class FriendRegistrationViewController: UITableViewController, UISearchResultsUpdating {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.returnKeyType = .done
        searchController.dimsBackgroundDuringPresentation = false
        return searchController
    }()
    
    var people = [User]()
    
    var service = UserLookupService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        service.fetch { [weak self] (result) in
            switch result {
            case .success(let users):
                self?.people = users
                self?.tableView.reloadData()
            case .failure(_):
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:- UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        service = UserLookupService()
        service.fetch(with: searchController.searchBar.text ?? "") { [weak self] (result) in
            switch result {
            case .success(let users):
                self?.people = users
                self?.tableView.reloadData()
            case .failure(_):
                break
            }
        }
    }
    
    // MARK:- UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendRegistrationTableViewCell", for: indexPath) as! FriendRegistrationTableViewCell
        cell.nameLabel.text = people[indexPath.row].name
        return cell
    }
    
    // MARK:- UITableViewDataSource
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alertController = UIAlertController(title: "確認", message: "フレンド登録しますか？", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: { _ in }))
        alertController.addAction(UIAlertAction(title: "登録", style: .default, handler: { _ in }))
        present(alertController, animated: true, completion: nil)
    }
}
